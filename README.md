# SofaNBA-iOS 📱 



## Introduction

This repository contains demo app as a result of the final project of the SofaScore iOS Academy. Now, the thing is, this app consists of a couple of screens here and there which may appear as they work but they will fail you, they'll fail you miserably 😅 . Jokes aside, I tried to make a replicate of SofaNBA iOS app based on the given specification provided by [Ante](https://github.com/AntePrpic) who was the mentor during the course, needless to say I broke every possible deadline there is but guy had understanding all along the way - special thanks to him 👏! I will now present you with this `README` file structure so that you know what to expect when going through this repository and, if you want to experience pain, actually cloning the repo and trying to setup up this beast locally on your machine. 

Buckle up, we are up for the wild ride... 😉  

## Explore Screen

The whole story starts with the explore screen. Now, you may ask yourself why would anyone want to go to the explore screen, or you probably won't. But I'll explain it to you anyways. Explore screen provides you with the possibility of browsing through NBA teams and players. Along with that, you can also filter teams and players by their name and team abbreviation - i.e. for Los Angeles Lakers it would be LAL. Meanwhile, if you are really, really into some of the teams and/or players you can additionally store them as your favorites by clicking on that blue star icon ⭐️  (by the way, that should be colored in red, but I guess that won't be the main problem here, innit). After clicking this star icon it will fill itself in blue color and you will also have the opportunity to view chosen team or player in the favorites screen, but we will get to that part.      

![](https://github.com/ismandre/SofaNBA-iOS/blob/main/Screenshots/explore_players.jpeg)
![](https://github.com/ismandre/SofaNBA-iOS/blob/main/Screenshots/explore_players_filter.jpeg)
![](https://github.com/ismandre/SofaNBA-iOS/blob/main/Screenshots/explore_teams.jpeg)

As you can see from the images presented above ☝️ there are three use cases illustrated about the way app is supposed to be used. First of all, on the leftmost image you can see players displayed alongside with their images, names, abbrevation of the team for which they play and, of course, the famous star icon. Some of the players are already checked as favorite ones just to demonstrate later that they will show up on the Favorites screen. Alongside with that, there are some rudimentary 🔍  filtering options provided in a way that it is possible for the user to filter players based on the some sequence of characters they might contain in either their firstname of lastname or both. This is also applicable for teams filtering but this is performed based on teams name. To conclude this section, it is important to mention that filtering can also be performed using keywords in a form of a team name abbreviation prepared in advance. Bonus: it works for both teams and players!     


### Player Details Screen

Now, if you are one of the collaborators for the project you can safely skip this part... and the next one also. You may wonder why is that the case. Well, there are things called deadlines and it is safe to say that they are getting the best out of me, in a way. The result of this loving relationship between me and the deadlines 📆 is that there are occasionally some parts of the project I don't quite make it on time. In reality, after clicking on some of the players or teams you should be directed to the screen containing more information about that player or team, but at the time speaking, this functionality is not provided. Will it ever be? Yup. It's just that I am more into exams and stuff. But, for the time being, let's say that this part is left for the future work. 

### Team Details Screen

This section could actually be copy-pasted from the previous one with performing replacement every time word `player` occurs with word `team`, sort of. I am actually planning to do this part some time later 'cause of reasons already stated before. But I'll do it, eventually 👍. 

## Favorites Screen

As mentioned earlier, for every team and player visible on the explore screen it is possible to add them to your favorites list. When switching from the Explore screen to the Favorites screen you will actually have a chance to go through your favorites and players and teams will be separated and marked using keywords `Players` and `Teams`. You can also notice the `Edit` ✍️  up there in the right corner which allows you switch in mode in which you can reorder cells - meaning players or teams in their respective sections. After you are done with this setup, it is also possible to press `Done` ✅  button and then the reording option will not be available anymore.

![](https://github.com/ismandre/SofaNBA-iOS/blob/main/Screenshots/favorites_before_reorder.jpeg)
![](https://github.com/ismandre/SofaNBA-iOS/blob/main/Screenshots/favorites_after_reorder.jpeg)
![](https://github.com/ismandre/SofaNBA-iOS/blob/main/Screenshots/favorites_cleared.jpeg)

## Settings Screen

Settings screen ⚙️ provides you with four radio button allowing to switch from metric to imperial units and also to switch between `Home vs Visitor` and `Visitor vs Home` option when displaying matches. There is also `About` section displaying basic user info, or the popular song from Dara Bubamara in this case. Related to the Favorites screen referenced earlier, you can also notice the `CLEAR MY FAVORITES LIST` button which does exactly that - clears every record stored in the favorites being that a player or a team. 

![](https://github.com/ismandre/SofaNBA-iOS/blob/main/Screenshots/settings.jpeg)

## Seasons Screen

This is another part of the app which I consider as a part of the future work. I will spend too much time describing what functionalities this screen should offer to the user, I will just point out that once parts previously described as the future work are done, I will proceed to implement requirements related to this screen and then I will spend some time presenting what you should expect from this screen, until then - be patient!


