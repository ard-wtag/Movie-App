# frozen_string_literal: true

# Pin npm packages by running ./bin/importmap

pin 'application'
pin 'hello', to: 'hello.js'
pin 'confirmation', to: 'confirmation.js'
pin 'star', to: 'star_rating.js'
pin_all_from 'app/javascript/controllers', under: 'controllers'
