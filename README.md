# xv6
###Acknowledgement:
Initial version of xv6 was taken from here:

1.  http://pdos.csail.mit.edu/6.828/2011/xv6.html
2.  https://github.com/mit-pdos/xv6-public

The actual owner, contributors and borrowed resources of that version are as acknowledged there.

###Contribution to this version:
This version was made by:

Sparsh Saurabh [(sparsh99)](https://github.com/sparsh99)

Vishwamangal Kumar [(vishwamangal)](https://github.com/vishwamangal)
	
This version was made as part of an assignment at IIT Mandi, in Feb-June,2016

###About this version:
    History command added. 
      For this purpose following codes were edited:
      a.  sh.c
      b.  ulib.c
      c.  makefile
      d.  user.h
      And following file was added:
      a.  history.c

###Procedure to use:
  1.  Use to clone to your local computer:
  
  	```
  	git clone https://github.com/sparsh99/xv6.git
  	```
  	
  2.  	Now try in the terminal: 
  	`make`
	and then,
        `make qemu`
        
  3.	Apart, from the features in the older version of xv6( of mit-pdos/xv6-public), a `history` command was added. This command can be tested after `make qemu` in xv6 terminal. Just type `history` and you can see the history.

###Known issues:
1.  In some computers, after cloning, make gives an error related to "mkfs" file. The solution to this issue is that delete the mkfs file, and perform "make" and "make qemu" again, and it would work.
