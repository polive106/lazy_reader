import { Controller } from "stimulus";
import { csrfToken } from "@rails/ujs";
import * as qna from '@tensorflow-models/qna';
export default class extends Controller {
  static targets = ['root', 'url', 'questionGroup', 'questionInput', 'answer']
  connect() {
  }

  getContent() {
    return new Promise((resolve, reject) => { // returns a promise so that it can be called in an await or .then manner (see getAnswers for example of async)
      const articleId = this.rootTarget.dataset.articleUid;
      const fetchUrl = this.rootTarget.dataset.url;
      fetch(fetchUrl, { headers: { accept: 'application/json' }})
        .then(response => response.json())
        .then((data) => {
          resolve(data.content)
        })
      })
  };

  async getAnswer() {
    if (!this.model) {
      console.log("loading model")
      this.model = await qna.load(); //loading model if not already done --> loading it in an instance variable
    } else {
      console.log("model already loaded")
    }
    console.log('loading passage')
    const passage = await this.getContent()
    const question = await this.getQuestion();
    console.log("getting answers")
    const answers = await this.model.findAnswers(question, passage);
    this.formatQuestion(question);
    this.appendAnswer(answers); // && to add answer
  }

  getQuestion() {
    return this.questionInputTargets.pop().value // returns last question
  }

  appendAnswer(answerArray) {
    const answer = answerArray[0] ? answerArray[0].text : "I don't have that information"
    this.rootTarget.insertAdjacentHTML('beforeend', `<p class="answer">${answer}</p>`)
    this.rootTarget.insertAdjacentHTML('beforeend',
      '<div class="input-group" data-tf-target="questionGroup">\
        <input type="text" class="form-control" placeholder="Ask me anything!" data-tf-target="questionInput">\
        <div class="input-group-append">\
          <button class="btn btn-primary" type="button" data-action="click->tf#getAnswer">\
            <i class="fas fa-paper-plane"></i>\
          </button>\
        </div>\
      </div>'
    )

  }

  formatQuestion(question) {
    this.questionGroupTarget.innerHTML = `<p class="question">${question}</p>`
    this.questionGroupTarget.removeAttribute('data-tf-target')
  }
}
