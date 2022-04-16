import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
    initialize() {}
    toggleForm(event) {
        event.preventDefault();

        console.log('button clicked');
        const formID = event.params['form'];
        const commentBodyID = event.params['body'];
        const editButtonID = event.params['edit'];

        const form = document.getElementById(formID);
        const commentBody = document.getElementById(commentBodyID);
        const editButton = document.getElementById(editButtonID);
    }
}
