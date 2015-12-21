# Night Writer

## Turing School: Module 1, Project 1

### Project Overview

The purpose of this project is to enable the conversion of plain text characters to Braille-like text and vice versa.

The idea of [Night Writing](https://en.wikipedia.org/wiki/Night_writing) was first developed for Napoleon's army so soldiers could communicate silently at night without light. 
The concept of night writing led to Louis Braille's development of his [Braille tactile writing system](https://en.wikipedia.org/wiki/Braille).

Braille uses a two-by-three grid of dots to represent characters. 
For this project, the concept is simulated by using three lines of symbols:

```
0.0.0.0.0....00.0.0.00
00.00.0..0..00.0000..0
....0.0.0....00.0.0...
```

The `0` represents a raised dot. The period `.` is an unraised space. The above code reads "hello world" in normal text. 

## Example

Contents of message.txt:
```
Hello World!
```

The program is used from the command line like so:

```
$ ruby lib/night_writer.rb message.txt braille.txt
Created "braille.txt" containing 28 characters
```

This reads the plain text file `message.txt` and creates a Braille simulation file `braille.txt`.
If no read or write files are added in the command line, they will default to these same files.
The Braille files are constrained to eighty characters wide, after which they will wrap to the next 3 lines.

Contents of braille.txt:
```
..0.0.0.0.0......00.0.0.00..
..00.00.0..0....00.0000..000
.0....0.0.0....0.00.0.0...0.
```

The Braille simulation is converted back to normal text in a similar manner and again, if no read or write files are added, they will default to the files below:

```
$ ruby lib/night_reader.rb braille.txt output_message.txt
Created 'output_message.txt' containing 12 characters.
```

### Capitalization

The lowercase letters used are from the American Foundation for the Blind and can be found [here](http://braillebug.afb.org/braille_print.asp).

In Braille, capitalization comes from a shift character. 

Capital letters `ABC`:
```
..0...0...00
......0.....
.0...0...0..
```
When that character appears, the next character (and only the next character) is a capital. 
The letter `e` comes out as one 2x3 set of Braille points, but `E` is 4x3: the shift character followed by the normal `e`.

### Numbers

Representations for 1-9 are actually the same as
a-i. This number sign is a "switch" which means that all of the following "letters",
up to the next space, are actually numbers. After the space it's assumed that
we're back to using words/letters until we see another number switch.

Numbers `123`:
```
.00.0.00
.0..0...
00......
```

### All Characters

Contents of `message.txt`
```
" !',-.?abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
```

Contents of `braille.txt` after running `ruby lib/night_writer.rb` from the command line:
```
..............0.0.00000.00000..0.00.0.00000.00000..0.00.0..000000...0...0...00..
..00..0...000...0....0.00.00000.00..0....0.00.00000.00..0.00...0.0......0.......
..0.0...00.000....................0.0.0.0.0.0.0.0.0.0.0000.0000000.0...0...0...0
00..0...00..00..0....0...0..0...0...00..00..0...00..00..0....0...0..0...0....0..
.0...0..0...00..00..0...00......0........0...0..0...00..00..0...00......0...00..
...0...0...0...0...0...0...00..00..00..00..00..00..00..00..00..00..000.000.0.0.0
00..00..0..0.00.0.00000.00000..0
.....0...0.000..0....0.00.00000.
00.000.00000....................

```
