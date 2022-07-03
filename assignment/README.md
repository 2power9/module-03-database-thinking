# Assignment

## Problem statement

Design schema for photo sharing program, almost like [Pinterest](https://pinterest.com), details as follows:

- Users share images by creating a pin (pin) with title, description, images, and pins.
- The generated pin must be on a certain board. The board can be either public or private: other users cannot see the pin in the board. However, the private board can invite other users to collaborate: create pins, reply to comments, . . .
- User can save another user's pin to his board.
- User can comment, like pins.
- User can follow many other users.

## Requirements

- Analyze requirements, then design APIs, database schema.
- Each API designs possible (tuned) queries, drawing workflows using planUML or drawio
- Design sharding on the application layer.
- Write detailed documentation of database schema, queries, sharding.

### Feature requests

- Create an account (username/password, email, ...)
- Allows user to create, view pin, create board.
- Users can save other people's pins.
- Users can follow others.
- For users to use comments, like the pin

## Solution

|      ![](https://i.imgur.com/fD7ogll.png)      |
|:----------------------------------------------:| 
| Relational table diagram for `PinterestClone`  |

Document: <https://dbdocs.io/andrena2209/PinterestClone>


### Some APIs 

| ![](https://i.imgur.com/DeadrKh.png)  |
|:-------------------------------------:|
|             add follower              |

|![](https://i.imgur.com/8IpWNl6.png)|
|:----------------------------------:|
|           create account           |

| ![](https://i.imgur.com/UzMJ0YG.png) |
|:------------------------------------:|
|             create board             |

| ![](https://i.imgur.com/nGARhsq.png) |
|:------------------------------------:|
|            create comment            |

| ![](https://i.imgur.com/F0I64Nv.png) |
|:------------------------------------:|
|              create pin              |

| ![](https://i.imgur.com/H11PQ9C.png) |
|:------------------------------------:|
|                react                 |

| ![](https://i.imgur.com/VX6yrYT.png) |
|:------------------------------------:|
|               save pin               |

| ![](https://i.imgur.com/o9d1Fn2.png) |
|:------------------------------------:|
|               see pins               |