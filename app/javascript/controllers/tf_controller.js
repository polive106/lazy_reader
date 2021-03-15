import { Controller } from "stimulus";
import { csrfToken } from "@rails/ujs";
import * as qna from '@tensorflow-models/qna';
export default class extends Controller {
  static targets = ['root', 'url']
  connect() {
    this.getAnswers()
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

  async getAnswers() {
    console.log('loading passage')
    const passage = await this.getContent()
    const question = "Daft Punk left Virgin for ?";
    console.log('loading model')
    const model = await qna.load();
    console.log('model loaded')
    const answers = await model.findAnswers(question, passage);
    console.log(answers)
  }
}
