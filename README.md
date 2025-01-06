# task_manager_flutter

A Flutter app to help you manage your everyday task.

## App Features

- google signin
- filter by category
- filter by date
- search by category or title
- create task
- delete task
- update task
- light mode & dark mode

## Instalation Steps

1. clone this project into your repository
2. run "flutter pub get" on terminal
3. you can run by pressing f5 or type "flutter run" on terminal

## Why Provider and Clean Architecture

I've been trying some state management such as streamcontroller, bloc and getx and getting a conclusion which is:
1. streamcontroller is the oldest and quiet a hassle to implement it.
2. bloc can be a readable choice for state management but too much syntax and its infuriating.
3. getx is very easy to implement it has a lot of function too but in terms of readable... not quiet
4. provider has (in my opinion) readable syntax and easy to implement. just a few code here and there and you have a state management.

 that is why i choose provider for state management and maybe i just used to it.

as for why clean... because i think its a good architecture than MVVM in terms of neatness but again... maybe its because i used to it



