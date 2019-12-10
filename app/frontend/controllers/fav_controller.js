import { Controller } from "stimulus"
import axios from 'axios';

export default class extends Controller {
  static targets = ["icon"]

  connect() {
    console.log('hi');
  }

  toggle(evt){
    evt.preventDefault();

    axios.post('/api/books/11/favorite')
         .then(function(response){
          console.log(response);
         })
         .catch(function(error){
           console.log('error');
         })

  }
}
