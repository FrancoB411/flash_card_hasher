# Chapter 1. General Unix and Advanced C

## Everything is a file!


everything is a file
  ~ An often-quoted tenet of UNIX-like systems such as Linux or BSD


In a word processor, with the file metaphor, what would be the operations?
  ~ 1. Read it (existing saved data from the word processor).
  2. Write to it (new data from the user).


Using the file metaphor, what would be the operations for a screen or printer?
  ~ Write only file


Using the file metaphor, what would be the operations for a mouse or keyboard or CD ROM?
  ~ Read only file


File
  ~ A conceptual abstraction for a sink or source of data, for all devices one might attach to a computer


The primary concept that underpins all modern computing
  ~ abstraction


## Implementing abstraction


What implements abstraction?
  ~ the application programming interface


API
  ~ a somewhat nebulous term that means different things in the context of various programming endeavours. Fundamentally, a programmer designs a set of functions and documents their interface and functionality with the principle that the actual implementation providing the API is opaque.


How do classes exemplify abstraction?
  ~ Methods provide the interface to the class, but abstract the implementation.


### Implementing abstraction with C


function pointers
  ~ A common method used in the Linux kernel and other large C code bases, which lack a built-in concept of object-orientation


example of function pointers
  ~ ``
  /* The API to implement */
  struct greet_api {
    int (*say_hello)(char *name); /* <--function pointer */
    int (*say_goodbye)(void); 
  };

  /* Our implementation of the hello function */
  int say_hello_fn(char *name) {
    printf("Hello %s\n", name);
    return 0; 
  }

  /* Our implementation of the goodbye function */
  int say_goodbye_fn(void) {
    printf("Goodbye\n");
    return 0; 
  }
  
  /* A struct implementing the API */
  struct greet_api greet_api = {
   .say_hello = say_hello_fn,
   .say_goodbye = say_goodbye_fn
  };

  /* main() doesn't need to know anything about how the * say_hello/goodbye works, it just knows that it does */
  int main(int argc, char *argv[]) {
    greet_api.say_hello(argv[1]);
    greet_api.say_goodbye();
    printf("%p, %p, %p\n", greet_api.say_hello, say_hello_fn, &say_hello_fn);
    exit(0); 
  }
``
function pointer
  ~ describes the prototype of the function it must point to; pointing it at a function without the correct return type or parameters will generate a compiler warning at least; if left in code will likely lead to incorrect operation or crash


Dunder [function name]
  ~ double-underscore function \_\_foo may conversationally be referred to as "dunder foo" (dun for double underscore)


Api idiom for more complex functionality
  ~ API implementation functions will only be a wrapper around other functions that are conventionally prepended with one or or two underscores


What do underscores in front of functions signal?
  ~ a visual warning that the function is not supposed to be called directly from "beyond" the API


in `&say_hello_fn` what does the `&` do?
  ~ takes the address of the function



## Libraries


Two roles Libraries have that illustrate abstraction
  ~ Allow programmers to reuse commonly accessed code.
  Act as a black box implementing functionality for the programmer.


libc
  ~ The standard library of a UNIX platform which provided the basic interface to the system


POSIX
  ~ the specification that enitrely describes the many calls that make up the standard UNIX API


## File Descriptors


Standard Files Provided by Unix
  ~ stdin, stdout, stderr


File numbers for stdin, stdout, stderr
  ~ 0, 1, 2 respectively


stdin
  ~ input from the keyboard


stdout
  ~ Output to the console


stderr
  ~ Error output to the console


File descriptor
  ~ The value returned by an open call. An index into an array (descriptor table) of open files kept by the kernel. The gateway into the kernel's abstractions of underlying hardware


How does the Kernel respond to an `open` call?
  ~ The Kernel creates a file descriptor and associates the file descriptor with some abstraction of an underlying file-like object, be that an actual hardware device, or a file system or something else entirely. Consequently a process's read or write calls that reference that file descriptor are routed to the correct place by the kernel to ultimately do something useful.


`/dev`
  ~  Special file system on the host that represent Physical devices on the host 


What happens when a file is opened?
  ~ when a file is opened the kernel is using the path information to map the file descriptor with something that provides an appropriate read and write, etc., API.


What do the major and minor number of the opened device node provide?
  ~ The information the kernel needs to find the correct device driver and complete the mapping. The kernel will then know how to route further calls such as read to the underlying functions provided by the device driver.


mount point
  ~ Abstraction which sets a mapping so the file system knows the underlying device that provides the storage and the kernel knows that files opened under that mount-point should be directed to the file system driver.


What API are file systems written to?
  ~ file systems are written to a particular generic file system API provided by the kernel.


## The Shell


The Shell
  ~ The gateway to interacting with the operating system. 


Fundamentally the major task of as shell
  ~ To allow you to execute programs 


## Redirection


redirect to a file
  ~ `> filename`  Take all output from standard out and place it into filename. Note using >> will append to the file, rather than overwrite it.


read from a file
  ~ `< filename`  Copy all data from the file to the standard input of the program


Pipe to a file
  ~ `program1 | program2`   Take everything from standard out of program1 and pass it to standard input of program2


Pipe
  ~ The pipe is an in-memory buffer that connects two processes together. This is one of the fundamental forms of inter-process communication or IPC in UNIX-like operating systems


### Implementing pipe


Where is a pipe's buffer stored?
  ~  pipe buffers are estored by the kernel until a corresponding read from the other side drains the buffer


How is pipe implemented?
  ~ Instead of associating the file descriptor for the standard-output with some sort of underlying device, the descriptor is pointed to an in-memory buffer provided by the kernel commonly termed a pipe. Another process can associate its standard input with the other side of this same buffer and effectively consume the output of the other process.


How can pipes work as a signalling channel?
  ~ If a process reads an empty pipe, it will by default block or be put into hibernation until there is data available Thus two processes may use a pipe to communicate just by writing a byte of data; Say for example one process requests that another print a file The two processes may set up a pipe between themselves where the requesting process does a read on the empty pipe; being empty, that call blocks and the process does not continue. Once the print is done, the other process can write a message into the pipe, which effectively wakes up the requesting process and signals the work is done.









