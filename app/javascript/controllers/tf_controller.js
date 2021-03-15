import { Controller } from "stimulus";
import { csrfToken } from "@rails/ujs";
export default class extends Controller {
  static targets = ['root', 'url']
  connect() {
    this.getArticle()
  }

  getArticle() {
    const articleId = this.rootTarget.dataset.articleUid
    const fetchUrl = this.rootTarget.dataset.url
    fetch(fetchUrl, { headers: { accept: 'application/json' }})
      .then(response => response.json())
      .then((data) => {
        console.log(data.content)
      })
  }
}
