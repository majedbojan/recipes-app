// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("trix")
require("@rails/actiontext")

import bsCustomFileInput from 'bs-custom-file-input'
import '../stylesheets/application.scss'
import '../utils/bootstrap'
import 'controllers'

require.context('../images', true)

$(document).on('turbolinks:load', e => {
    $(".alert.alert-dismissible").delay(4000).slideUp(200, _ => $(this).alert('close'));
    $('[data-toggle="tooltip"]').tooltip()
    $('[data-toggle="popover"]').popover()
    bsCustomFileInput.init()
    $('.carousel').carousel({ interval: 3000 })
})