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

| ![](media/add-follower-0.png) |
|:------------:|
| add follower |

|   ![](media/create-account-0.png)   |
|:---------------------------------:|
| create a new account              |

| ![](media/create-board-0.png) |
|:------------:|
| create board |


| ![](media/create-comment-0.png) |
|:-------------------------------:|
|         create comment          |


| ![](media/create-pin-0.png) |
|:---------------------------:|
|         create pin          |


| ![](media/react-pin-0.png) |
|:--------------------------:|
|         react pin          |


| ![](media/save-pin-0.png) |
|:------------:|
|   save pin   |

| ![](media/see-pins-0.png)  |
|:--------------------------:|
|          see pins          |
