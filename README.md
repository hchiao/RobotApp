Introduction:
========
Robot takes a set of commands to moving on a board.  The robot has to also follow a set of rules whiles moving.
(Please see added file for full set of rules)

How to run:
========
In the root folder, type the following:
  ```bash
  ruby main.rb
  ```
How to set commands for robot:
========
Each set of commands is a run.  All run yaml files are located in the runs folder.  In the config.yml(app/config/config.yml) file, you can
set which yml file the robot is going to exectue.  You can create your own runs according to the format in the other examples.

Advance configuration:
========
By default, the object that is moving on the arena is "Robot", and the space in which the object is moving(arena) is set to "Board".
In the config.yml file, you can also set the object as "Lizard", and the arena to "BadBoard".

"Robot" moves according to the document rules, whereas "Lizard" moves 3 spaces at once and turn erratically.

"Board" act according to the document rules.  "Board" will ingore commands that make objects fall off the arena, and it will ignore 
any commands before the object is placed on the arena.  "BadBoard" will let the object fall off the arena and stop(throw exception).

User can create own object or board as long as the object is placed in the configuration.rb file and supplies the methods as follows:
Object: 
    clone
    place
    move!
    turn_left!
    turn_right!
    report

Arena:
    take_action


