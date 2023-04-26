# Flamegraphs

```
                           d'b 8                                                  8
                           8   8                                                  8
                          o8P  8 .oPYo. ooYoYo. .oPYo. .oPYo. oPYo. .oPYo. .oPYo. 8oPYo. .oPYo.
                           8   8 .oooo8 8' 8  8 8oooo8 8    8 8  `' .oooo8 8    8 8    8 Yb..
                           8   8 8    8 8  8  8 8.     8    8 8     8    8 8    8 8    8   'Yb.
                           8   8 `YooP8 8  8  8 `Yooo' `YooP8 8     `YooP8 8YooP' 8    8 `YooP'
                          :..::..:.....:..:..:..:.....::....8 ..:::::.....:8 ....:..:::..:.....:
                          :::::::::::::::::::::::::::::::ooP'.:::::::::::::8 :::::::::::::::::::
                          :::::::::::::::::::::::::::::::...:::::::::::::::..:::::::::::::::::::
                                                                                                            
                                                                %%                                          
                                                               *+*                                          
                                                              %+++%                                         
                                                              %+++%                                         
                                                               \**                                          
                                                                                                            
                                                           \**        %                                     
                                                         %*++*      /++/                                    
                                                        /++++*     /+++*                                    
                                                       %++++++    /+++++\                                   
                                                       *++++++\   \+++++*                                   
                                                      /++++++++%  \+++++/                                   
                                               **\%   \+++++++++/  *++\%  %%%                               
                                               *+++*/ +++++++++++\  // %\+++*                               
                                               \++++++++++++++++++*% %*++++\                                
                                               /++++++++++++++++++++\+++++*                                 
                                               \++++++++++++++++++++++++++/    /**                          
                                               ++++++++++++=++++++++++++++\   %+++\                         
                                         \*/  \++++==++++++==++++=++++++++*   \++++                         
                                  /+*%   \++**+++++===+++++====++=+++++++++/  *++++%                        
                                  *+++   /+++++++++====+++=====++=++++++++++  *+++*                         
                                %*++++/  \++++++++++==+++=======++++++++++++* /++*                          
                                *+++++/  *++++++==++++++========++===++++++++* %/%%                         
                               %+++++*  \++++++++===+++========-=====+++++++++*% *+*                        
                                ++++\  \+++++++++====================+++++++++++*+++%                       
                                %*++/ \++++==++++===========-========+++++++++++++++\                       
                                  /\\\+++++-==+++=========---=========++=++++++++++++                       
                              \\\%  \++++++===++=========--:-===========-++++=+++++++/                      
                              ++++**++++++++=+++=========-:::-===========+++====+++++*                      
                              \+++++++++++++++=======-----::::-===---=====+++===++++++                      
                              %+++++++++++==+========-::-::::::---:-=======+++-=++++++%                     
                               \++++++++++===========-:::::::::::::-=======+++=+++++++                      
                                *++++++++=========----:::::::::::::-========+++++++++*                      
                                %*+++++++=========-:::::::::::::::::-========++===+++%                      
                                  \++++++-========-:::::::::::::::::--=-=========+++/                       
                                   %*++++-=======-::::::::::::::::::::-:-========++/                        
                                     %\++====-==-:::::::::::::::::::::::-=======+*%                         
                                        /+==-:--:::::::::::::::::::::::::-=====\%                           
                                          %\+--::::::::::::::::::::::::::-=+\%                              
                                              %/*+---::::::::::::::--=+*/%                                  
                                                    %%//\/////////%                                         
                                                                                                    

```

[ascii source](https://github.com/rghvv/ASCII-Art-Generator/blob/fe4334d14a2dcbe8ea02ef052b796b0d4ead3bdd/Sample%20Outputs/fire.txt#L1)
text generation: `figlet -f jazmine -w 400 "flamegraphs"`


## What are Flamegraphs?


> Flame Graphs visualize profiled code
[brandangregg/FlameGraph](https://github.com/brendangregg/FlameGraph)

> Produces flame graphs from hierarchical data
[spiermar/d3-flame-graph](https://github.com/spiermar/d3-flame-graph)

> A flame graph visualizes a distributed request trace and represents each service call that occurred during the request's execution path with a timed, color-coded, horizontal bar
[DataDog: What is a Flame Graph? How it Works & Use Cases](https://www.datadoghq.com/knowledge-center/distributed-tracing/flame-graph/#:~:text=A%20flame%20graph%20visualizes%20a,fix%20bottlenecks%20in%20their%20applications.)

> Flame graphs are a visualization of hierarchical data, created to visualize stack traces of profiled software so that the most frequent code-paths to be identified quickly and accurately.
https://www.brendangregg.com/flamegraphs.html

> A powerful tool for undrestanding how your program runs
- me

## Hi

Josh Nichols

aka technicalpickles

I work at Gusto

I'm easily nerdsniped by performance issues

## An example program

Let's look at a program (simple.rbl

What does this do? `hello` is called, which calls `world`, whicih calls `itsa`

```
❯ ruby simple.rb
main
hello
world
itsa me pickles
sup
yall
```

## Profiling

Imagine we already have a tool to profile and visualize.. it might look like:

```
[-------- main ----------------------------------------------]
[--------------hello---][-------- sup ----------][-- yall--]
      [-----------world]
           [-------itsa]
```

## Caller

There's a handy ruby method `caller`

Shows the stack trace of the program at the time it's called

Let's add that to our log message:

```
❯ ruby simple.rb                                                              ─╯
main
simple.rb:35:in `<main>'

hello
simple.rb:37:in `<main>'
simple.rb:8:in `hello'

world
simple.rb:37:in `<main>'
simple.rb:10:in `hello'
simple.rb:14:in `world'

itsa me pickles
simple.rb:37:in `<main>'
simple.rb:10:in `hello'
simple.rb:16:in `world'
simple.rb:20:in `itsa'

sup
simple.rb:38:in `<main>'
simple.rb:25:in `sup'

yall
simple.rb:39:in `<main>'
simple.rb:30:in `yall'
```

What if we lined them up horizontally?

[simple.txt](simple.txt)

That is getting pretty close to the visualize.

Now imagine constantly capturing these stack traces, and automatically grouping them like we just did

## Flamegraph

Now let's try looking at a real flamegraph.

I've built a gem called [singed](https://github.com/rubyatscale/singed). Built on these excellent tools:

It wraps profiling your code with stackprof or rbspy, and then launching speedscope to view it.

- [stackprof](https://github.com/tmm1/stackprof)
- [rbspy](https://github.com/rbspy/rbspy)
- [speedscope](https://github.com/jlfwong/speedscope)

## Running it

Let's run it:

```
❯ bin/singed ruby simple.rb
🔥📈 Singed needs to run as root, but will drop permissions back to your user. Prompting with sudo now...
Password:
$ sudo --preserve-env rbspy record --format speedscope --file /var/folders/92/0kw80yh95bz8b431qwjvmctm0000gn/T/speedscope-cli-20230426102911.json --silent -- ruby simple.rb
Dropping permissions: running Ruby command as user josh.nichols
rbspy is recording traces. Press Ctrl+C to stop.
main
simple.rb:35:in `<main>'

hello
simple.rb:37:in `<main>'
simple.rb:8:in `hello'

world
simple.rb:37:in `<main>'
simple.rb:10:in `hello'
simple.rb:14:in `world'

itsa me pickles
simple.rb:37:in `<main>'
simple.rb:10:in `hello'
simple.rb:16:in `world'
simple.rb:20:in `itsa'

sup
simple.rb:38:in `<main>'
simple.rb:25:in `sup'

yall
simple.rb:39:in `<main>'
simple.rb:30:in `yall'

Wrote raw data to /Users/josh.nichols/Library/Caches/rbspy/2023-04-26-wdxpGPf6CJ.raw.gz
Wrote formatted output to /var/folders/92/0kw80yh95bz8b431qwjvmctm0000gn/T/speedscope-cli-20230426102911.json
$ sudo --preserve-env chown josh.nichols /var/folders/92/0kw80yh95bz8b431qwjvmctm0000gn/T/speedscope-cli-20230426102911.json
Creating temp file /var/folders/92/0kw80yh95bz8b431qwjvmctm0000gn/T/speedscope-1682519367683-10368.js
Creating temp file /var/folders/92/0kw80yh95bz8b431qwjvmctm0000gn/T/speedscope-1682519367683-10368.html
Opening file:///var/folders/92/0kw80yh95bz8b431qwjvmctm0000gn/T/speedscope-1682519367683-10368.html in your default browser
```

Looks pretty close

## Aside

Flames burn up, right? Not down?

Yeah, I don't know when we switched from them going up to down

Theory: has to do with making it easy


## Interpretting this

If you are looking at a line, then the line above it called it

When looking at a 'frame':
- was called by the 'frame' above
- calls the frame below it
- for each point when there isn't a frame directly below it, time is spent in that method 

We are using `sleep` so it's pretty clear time is _only_ in that frame


## Rails

Single file rails app, let's run it:
```
❯ unicorn
[2023-04-26 10:32:40] INFO  WEBrick 1.6.1
[2023-04-26 10:32:40] INFO  ruby 2.7.5 (2021-11-24) [arm64-darwin21]
[2023-04-26 10:32:40] INFO  WEBrick::HTTPServer#start: pid=10489 port=8080
```
And hit the endpoint

```
❯ unicorn -p 8080 rails.ru                                                                                                        ─╯
I, [2023-04-26T10:39:54.485202 #11759]  INFO -- : listening on addr=0.0.0.0:8080 fd=11
I, [2023-04-26T10:39:54.485247 #11759]  INFO -- : worker=0 spawning...
I, [2023-04-26T10:39:54.486160 #11759]  INFO -- : master process ready
I, [2023-04-26T10:39:54.486608 #11772]  INFO -- : worker=0 spawned pid=11772
I, [2023-04-26T10:39:54.486829 #11772]  INFO -- : Refreshing Gem list
I, [2023-04-26T10:39:55.050130 #11772]  INFO -- : worker=0 ready
I, [2023-04-26T10:39:56.301871 #11772]  INFO -- : Started GET "/" for 127.0.0.1 at 2023-04-26 10:39:56 -0400
I, [2023-04-26T10:39:56.310440 #11772]  INFO -- : Processing by RootController#index as */*
D, [2023-04-26T10:39:59.316712 #11772] DEBUG -- :   Rendering text template
I, [2023-04-26T10:39:59.317166 #11772]  INFO -- :   Rendered text template (Duration: 0.0ms | Allocations: 3)
I, [2023-04-26T10:39:59.317764 #11772]  INFO -- : Completed 200 OK in 3007ms (Views: 5.4ms | Allocations: 909)


🔥📈 Captured flamegraph, opening with: npx speedscope tmp/speedscope/speedscope-20230426103956.json
Creating temp file /var/folders/92/0kw80yh95bz8b431qwjvmctm0000gn/T/speedscope-1682519999729-11787.js
Creating temp file /var/folders/92/0kw80yh95bz8b431qwjvmctm0000gn/T/speedscope-1682519999729-11787.html
Opening file:///var/folders/92/0kw80yh95bz8b431qwjvmctm0000gn/T/speedscope-1682519999729-11787.html in your default browser
127.0.0.1 - - [26/Apr/2023:10:39:59 -0400] "GET / HTTP/1.1" 200 - 3.4464
D, [2023-04-26T10:46:44.948435 #11759] DEBUG -- : waiting 31.0s after suspend/hibernation
D, [2023-04-26T10:53:25.286440 #11759] DEBUG -- : waiting 31.0s after suspend/hibernation
D, [2023-04-26T10:58:26.551058 #11759] DEBUG -- : waiting 31.0s after suspend/hibernation
^CI, [2023-04-26T10:58:39.436712 #11759]  INFO -- : reaped #<Process::Status: pid 11772 exit 0> worker=0
I, [2023-04-26T10:58:39.436922 #11759]  INFO -- : master complete
```

## Complexity

During Eileen's keynote, she said something to the effect of:

Rails focuses on making develoepr experience simple, and does that by taking on complexity


Guess what we are now seeing :D 

We have to do a lot of scrolling to find our application code. This is pretty common, unfortunately.

## Rails Boot time

```
❯ bin/singed  -- bin/rails runner true
🔥📈 Singed needs to run as root, but will drop permissions back to your user. Prompting with sudo now...
Password:
$ sudo --preserve-env rbspy record --format speedscope --file tmp/speedscope/speedscope-cli-20230426110625.json --silent -- bin/rails runner true
Dropping permissions: running Ruby command as user josh.nichols
rbspy is recording traces. Press Ctrl+C to stop.
Wrote raw data to /Users/josh.nichols/Library/Caches/rbspy/2023-04-26-3kpcSoreui.raw.gz
Wrote formatted output to tmp/speedscope/speedscope-cli-20230426110625.json
$ sudo --preserve-env chown josh.nichols tmp/speedscope/speedscope-cli-20230426110625.json
Creating temp file /var/folders/92/0kw80yh95bz8b431qwjvmctm0000gn/T/speedscope-1682521604552-12136.js
Creating temp file /var/folders/92/0kw80yh95bz8b431qwjvmctm0000gn/T/speedscope-1682521604552-12136.html
Opening file:///var/folders/92/0kw80yh95bz8b431qwjvmctm0000gn/T/speedscope-1682521604552-12136.html in your default browser
```


## Be curious, learn by doing

I've found it hard to teach this, but you can definitely learn by doing. And learn by working with people.

Gives you an opportunity to be curious. What is all that stuff? Let's find out!





## Let's Collaborate

If you are interested in digging into Rails boot performance, or any really, please reach out!

Would love to do some pairing 🍐

## Conclusion

Josh Nichols
@technialpickles / @techpickles

- https://github.com/technicalpickles/flamegraph-talk
- https://github.com/technicalpickles/singed
