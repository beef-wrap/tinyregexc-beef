/*
*
* Mini regex-module inspired by Rob Pike's regex code described in:
*
* http://www.cs.princeton.edu/courses/archive/spr09/cos333/beautiful.html
*
*
*
* Supports:
* ---------
*   '.'        Dot, matches any character
*   '^'        Start anchor, matches beginning of string
*   '$'        End anchor, matches end of string
*   '*'        Asterisk, match zero or more (greedy)
*   '+'        Plus, match one or more (greedy)
*   '?'        Question, match zero or one (non-greedy)
*   '[abc]'    Character class, match if one of {'a', 'b', 'c'}
*   '[^abc]'   Inverted class, match if NOT one of {'a', 'b', 'c'} -- NOTE: feature is currently broken!
*   '[a-zA-Z]' Character ranges, the character set of the ranges { a-z | A-Z }
*   '\s'       Whitespace, \t \f \r \n \v and spaces
*   '\S'       Non-whitespace
*   '\w'       Alphanumeric, [a-zA-Z0-9_]
*   '\W'       Non-alphanumeric
*   '\d'       Digits, [0-9]
*   '\D'       Non-digits
*
*
*/

using System;
using System.Interop;

namespace tinyregexc;

public static class tinyregexc
{
	typealias char = c_char;

	/* Typedef'd pointer to get abstract datatype. */
	public struct regex_t;

	typealias re_t = regex_t*;

	/* Compile regex string pattern to a regex_t-array. */
	[CLink] public static extern re_t re_compile(char* pattern);

	/* Find matches of the compiled pattern inside text. */
	[CLink] public static extern c_int re_matchp(re_t pattern, char* text, c_int* matchlength);

	/* Find matches of the txt pattern inside text (will compile automatically first). */
	[CLink] public static extern c_int re_match(char* pattern, char* text, c_int* matchlength);
}