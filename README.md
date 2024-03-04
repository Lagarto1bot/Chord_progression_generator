## General Info
As a passionate bass player and amateur music composer/producer I often face the problem of so called "beatblock" or just creativity crisis.
I really want to create something but I find my ideas dull and lifeless at times. That feeling led to creation of a tool that is not using any popular schemes.
It' just random and that's why it unclicks our pattern focused mindset while creating chord progressions.
In this project, which I had the pleasure of co-creating with a friend from the activity group (if he ever creates github account I'll gladly add mention here), we managed to make a simple random chord progression generator.
First we generate subset of given size: 1 to 7 chords in scale, than permutacje.m permutes our subset to randomize output ane make it interesting.
Next step we generate traids corresponding to the subset, in other words we create chords based on the numbers in created vector.
We do that just by defining few vectors that characterize each chord and for that we need only our base frequency which is set default as 220 Hz (A3).
Function GeneratorDzwieku takes generated triad frequencies, generates sine waves and enhances them with harmonics, which makes it sound warmer and more musical.

## Technologies
Beauty of this project is that you only need:
* Matlab R2023a
or
* Octave corresponding version for free

## Setup
Running this project requires you to have all m-files in the same directory.

## Example of use
This is quick video presentation of generator in action. It also prints names of each chord so user can quickly translate it to his musical instrument.
All frequencies appear on the semilogarythmic graph. 
Better with sound on.

https://github.com/Lagarto1bot/Chord_progression_generator/assets/62251491/5c9767df-2c77-405c-ad02-f013c2d5fe7d

