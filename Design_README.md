1. The user struct has two fields : email and name. A new user can be registered by clicking on the link 'Register' in the log in page. This design is similar to many commercial website login design. 

2. A user can login using email address.

3. Once logged in , the user is redirected to feed page. The feed page consists of the creating and viewing tasks created by all users.

4. Tasks struct consists of title,descritpion, time taken, status(whether a issue is completed or pending), assigned_to, assigned_by fields which are displayed on the feed. 

5. Tasks are designed as cards. Create tasks is where a user can create a task and assign it to any user using their user id. 

6. Each task can be edited by clicking on the edit link, here a user can update any field. If the task status is to be updated , then this link is used to do so. 

7. A task can be deleted by clicking on the delete button. A prompt is shown asking for confirmation. If the user confirms, that task is deleted.

8. On a error, or incomplete details given during task creation, it takes to a new page where there are no tasks listed , the errors are shown in red. The user can follow instructions to update the details as needed or can go back to feed page using the 'Back' link.

9. I have not linked the 'Show' page of user or Tasks to any active links on the screen since it was not necessary for the given requirements. 

10. The status of the task , if completed is shown in green 'Completed' , other wise it is shown in red 'Pending'. 

11. A user can see on top right of the feed page if he/she is logged in . A log out link next to it can be used to log out of the session.

TASKTACK -PART 2 :

1. User must first register using the register link and then use the same credentials to login to the Task tracker.

2. On the Task track feed, top left corner has three links - Feed, All users , Report. Clicking on each of these link redirect to appropriate pages. 
3. On the Feed page, all users can see reports of all other users , but only the user to whom the issue is assigned or hhis/her manager can modify the post. 
4. In all users page, if a user is not assigned any assignees, he/she can choose to manage a user who does not have a manager assigned. The user can release his/her managee from the same page. Only a manager can create issues for his/her managees. 

5. A user cannot manage his/her manager.

6. A user can edit his/her credentials only.

7. A user to whom a issue is assigned to can add/edit/delete a particular time block which appers on the issue block. He/ She can add a time block by using create time block with appropriate details filled. User can also add time block using start and stop time blocks. 

8. A user or the manager can modify/delete issues.

9. A manager can see a consolidated report of the tasks assigned to his managees in the Report page.

10. Only a user with managees gets a proper output otherwise the page displays error for other users.


