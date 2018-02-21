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
