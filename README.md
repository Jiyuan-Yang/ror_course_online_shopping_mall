# Online Shopping Mall Website Project

## Introduction

This is a project for our course in the university which is made by Ruby on Rails. We've designed a general model for common online shopping settings, and made an implementation of those entities and their relationship as well as web pages made by HTML using embedded Ruby (erb). Due to the well-designed architecture powered by Rails, you could easily DIY your own functions and pages based on the model we've already made. We'll be glad if this project could help you get further understanding about the features of Ruby on Rails or even make some contirbutions to your development. If you have any question or find any bug in this project, please raise an issue and let us know.

## Environment Preparation

The basic environment we used is `Ruby on Rails`, specifically,

```
Ruby version 2.5.1
Rails version 5.2.3
```

We recommend you to use this project on macOS, Linux or WSL (Windows Subsystem for Linux) on Windows. 

In order to get ready for this environment, it may be a better choice to install `rvm` first, a tool for ruby version controlling which could make it easier to manage different versions of `Ruby` and `Rails`.

In the `Terminal` of macOS, Linux or WSL, type

```
curl -L https://get.rvm.io | bash -s stable
```

to download `rvm`, if that fails, try

```
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
```

and try the previous command again. Then

```
source ~/.rvm/scripts/rvm
```

to activate `rvm`. Then use

```
rvm -v
```

if you see some messages like

```
rvm 1.29.9 (1.29.9) by Michal Papis, Piotr Kuczynski, Wayne E. Seguin [https://rvm.io]
```

the `rvm` is successfully installed on your device.

Then you could use `rvm` to install `Ruby` and `Rails`.

```
rvm install 2.5.1
rvm gemset create rails5
rvm use 2.5.1@rails5 --default
rvm install rails -v 5.2.3
```

After finishing all of those listed above, you are ready for a `Ruby on Rails` environment and could start to use this project. First, you have to use `cd` to change to the working directory of this project, 

```
cd Online_Shopping_Mall_RoR_Project/
```

The before we move on, use `bundle install` to install all the requirements (the gems). Notice that we use the source of gems in China, and in order to make this process faster, you could change it to the gem source of your country, in `Gemfile`, 

```ruby
# source 'https://rubygems.org'
# git_source(:github) { |repo| "https://github.com/#{repo}.git" }
source 'https://gems.ruby-china.com'
```

change the source (or you could just use the default source).

After that, everything is ready, type `rails server` to use this project. You may see messages like this in your terminal,

```
=> Booting Puma
=> Rails 5.2.3 application starting in development 
=> Run `rails server -h` for more startup options
[8504] Puma starting in cluster mode...
[8504] * Version 3.12.1 (ruby 2.5.1-p57), codename: Llamas in Pajamas
[8504] * Min threads: 5, max threads: 5
[8504] * Environment: development
[8504] * Process workers: 2
[8504] * Preloading application
[8504] * Listening on tcp://localhost:3000
[8504] Use Ctrl-C to stop
[8504] - Worker 1 (pid: 8516) booted, phase: 0
[8504] - Worker 0 (pid: 8515) booted, phase: 0
```

Pay attention to the message of `Listening on`, and type this (for example, in my computer, I type `localhost:3000`) in your web browser and then you could view our project.

When you first use this project, you may find some ERROR messages in your web browser like

```
ActiveRecord::PendingMigrationError
Migrations are pending. To resolve this issue, run: bin/rails db:migrate RAILS_ENV=development
```

Just follow the instructions, in the directory of this project, type

```
rails db:migrate 
```

Then reload the pages and everything will work well :-)