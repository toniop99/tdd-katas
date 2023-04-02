# TDD Katas

This repository contains a set of katas to practice Test Driven Development in a monorepo package.

## Introduction
In this repository you will find a set of katas to practice Test Driven Development. Each kata is a package in the 
`projects` folder.

Each package contains a `README.md` file with the instructions to solve the kata.

In the `projects/kata/src/Solution/` and `projects/kata/tests/Solution/` folder you will find a possible solution to the kata.

## Katas
- [Christmas Lights Kata](projects/fizz-buzz-kata/README.md)

## How To Use
`make help`: Show the available commands

Select the kata you want to solve and follow the instructions in the `README.md` file.

- `make docker/up`: Start the docker container
- `make composer/install`: Install the dependencies
- `make composer/run-test`: Run the tests

👀 You can check a possible solution in the `projects/kata/src/Solution/` and `projects/kata/tests/Solution/` folder.
- `make composer/run-test-solution`: Run the tests of the solution

## How To Contribute
If you want to contribute to this repository, you can do it in different ways:

- Create a new kata
- Improve the existing katas
- Improve the documentation

### Create a new kata
To create a new kata:
- `make bin/generate-kata kata=kata-name`
  - This command will create a new package in the `projects` folder with the name `kata-name`.
    Modify and add the files you need for the kata. Add a solution in the `projects/kata/src/Solution/` and `projects/kata/tests/Solution/` folder.

- `make composer/run-mono-merge`
  - This command will merge the `composer.json` files of the packages to the root composer package.

- Add the new kata to the `README.md` file.
- Make a pull request with the new kata. 😎

### Improve the existing katas
If you find a bug, or you want to improve the existing katas, make a pull request with the changes.

### Improve the documentation
If you find a typo, or you want to improve the documentation, make a pull request with the changes.