# CSM (Content System Management)

[![Docker](https://img.shields.io/badge/docker-ready-blue)](https://www.docker.com/)
[![Ruby on Rails](https://img.shields.io/badge/Rails-8.x-red)](https://rubyonrails.org/)
[![RSpec](https://img.shields.io/badge/tested%20with-RSpec-blue)](https://rspec.info/)

## Project Description

CSM (Content System Management) is a Ruby on Rails application designed to help users save and organize content they find important. In its initial phase, the application focuses on providing a personal space for users to curate and manage their valuable information. Future development aims to include features for sharing content among users, fostering collaboration and knowledge exchange.

This project is built with a focus on maintainability and scalability, leveraging modern web development practices and technologies.

## Key Features (Current Stage)

* **Content Storage:** Securely store various types of content (e.g., links, notes, articles).
* **Organization:** Implement a system for users to organize their content effectively (e.g., tags, categories).
* **User Authentication:** Basic user registration and login functionality.

## Technologies Used

* **Ruby on Rails:** The web application framework.
* **Docker:** Containerization for easy setup and deployment.
* **CI Workflow:** Github CI workflow integrated.
* **Test-Driven Development (TDD):** Ensuring code quality and reliability through comprehensive testing.
* **PostgreSQL:** The relational database system.
* **Tailwind CSS:** A utility-first CSS framework for rapid UI development.
* **RSpec:** A testing framework for Ruby.
* **Cuprite:** A Ruby drive to run Capybara tests on a headless Chrome or Chromium.
* **Faraday:** A HTTP client library abstraction layer that provides a common interface over many adapters.
* **FactoryBot:** A fixtures replacement with a straightforward definition syntax.
* **ShouldaMatchers:** Provides RSpec compatible one-liners to test common Rails functionality.
* **SimpleCov:** A code coverage analysis tool for Ruby.
* **Devise:** A flexible authentication solution for Rails based on Warden.

## Installation

## Prerequisites

Make sure you have the following software installed on your machine:

* **Git:** To clone the repository. You can download it from [git-scm.com](https://git-scm.com/).
* **Docker and Docker Compose:** Essential for running the application. Download and install them via [docker.com/products/docker-desktop](https://www.docker.com/products/docker-desktop/).

### How to Run the Application

To get the CSM application running quickly using Docker, follow these steps:

1.  **Clone the repository:**
    ```bash
    git clone git@github.com:Gabriel-T-P/CSM.git
    cd CSM
    ```

2.  **Build containers and run seeds:**
    ```bash
    docker compose build
    docker compose run --rm app rails db:reset
    ```

3.  **Run and access the application:**
    ```bash
    docker compose up
    ```
    Once the containers are running, the application should be accessible at `http://localhost:3000` in your web browser.
    To stop the application containers, press *Ctrl+C* in the terminal where docker compose up is running.

## Running Tests

This project follows Test-Driven Development (TDD), and tests are written using RSpec. To run the test suite:

1.  **Ensure you have the necessary dependencies installed** (either via Docker or `bundle install`).

2.  **Execute the RSpec tests:**
    ```bash
    bundle exec rspec
    ```
    Or with docker:

    ```bash
    docker compose run --rm app bundle exec rspec
    ```
    Those commands will run all the tests located in the `spec` directory.

## Contributing

Currently, this project is in its early stages and primarily for personal use. However, future contributions and feedback are welcome.

Thank you for checking out the CSM project! Stay tuned for future updates and features.
