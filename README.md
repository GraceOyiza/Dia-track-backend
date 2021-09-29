# DIATRACK API

A RESTFUL API built with Ruby on Rails. The application exposes API endpoints for a front end application. The application allows user to register, login, create measurement categories and measurement.

## End Points

There are a couple of endpoints exposed by this api and can be accessed online using `https://diatrack-backend.herokuapp.com/api/v1` as the base Url.

## POST

- /auth - (create user account)
  <br>
- /auth/sign_in - (log in to account)
  <br>

- /measures - (create measurement category)
  <br>

## GET

  <br>

- /me - (fetch user info)
- /measures - (fetch all measurement categories)
- /measurements - (fetch all measurements for current user)
- /measures/:id - (fetch one measurement category for current user)


## Built With

- Ruby on Rails
- Postgresql
- Heroku
- Rspec
- Devise-Auth-Token
- Cloudinary

## Live Demo

For the full working application Click [here](https://gymify-backend.herokuapp.com/api/v1)

## Installation

To get a local copy up and running follow these simple example steps.

### Setup

Clone [this](https://github.com/OlawaleJoseph/E-Vote-Backend.git) repository

### Follow:

1. cd into the project directory
2. run bundle install
3. run rails db:migrate
5. create rails credentials for cloudinary
6. run rails s to start the server.
7. Make request to the api via a tool such as Postman

### Run tests
  - run `rpsec`

***NOTE***
I had a faulty laptop this is the reason for the late submission of this project.

## Author

👤 **Popoola Grace Boluwatife**

- Github: [@GraceOyiza](https://github.com/GraceOyiza)
- Twitter: [@\_PopsonGrace](https://twitter.com/_PopsonGrace)
- LinkedIn: [@grace](https://www.linkedin.com/in/grace-popoola)
## 🤝 Contributing

Contributions, issues and feature requests are welcome!
Feel free to check the [issues page](https://github.com/GraceOyiza/DiaTracker/issues).
## Show your support

Give a ⭐️ if you like this project!
## Acknowledgments

- Microverse
- You can access all the design info (color, typography, layouts) at this link:
- Design(https://www.behance.net/gallery/13271423/Bodytrackit-An-iOs-app-Branding-UX-and-UI)
- Design idea by Gregoire Vella on Behance

## 📝 License