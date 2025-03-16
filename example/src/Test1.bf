using System.Interop;
using System.Diagnostics;

using static tinyregexc.tinyregexc;

namespace example;

static class Test1
{
	typealias Test = (bool, char8*, char8*, int);

	static Test[?] tests =
		.(
		(true,  "\\d",                       "5",                 1      ),
		(true,  "\\w+",                      "hej",               3      ),
		(true,  "\\s",                       "\t \n",             1      ),
		(false, "\\S",                       "\t \n",             0      ),
		(true,  "[\\s]",                     "\t \n",             1      ),
		(false, "[\\S]",                     "\t \n",             0      ),
		(false, "\\D",                       "5",                 0      ),
		(false, "\\W+",                      "hej",               0      ),
		(true,  "[0-9]+",                    "12345",             5      ),
		(true,  "\\D",                       "hej",               1      ),
		(false, "\\d",                       "hej",               0      ),
		(true,  "[^\\w]",                    "\\",                1      ),
		(true,  "[\\W]",                     "\\",                1      ),
		(false, "[\\w]",                     "\\",                0      ),
		(true,  "[^\\d]",                    "d",                 1      ),
		(false, "[\\d]",                     "d",                 0      ),
		(false, "[^\\D]",                    "d",                 0      ),
		(true,  "[\\D]",                     "d",                 1      ),
		(true,  "^.*\\\\.*$",                "c:\\Tools",         8      ),
		(true,  "^.*\\\\.*$",                "c:\\Tools",         8      ),
		(true,  ".?\\w+jsj$",                "%JxLLcVx8wxrjsj",   15     ),
		(true,  ".?\\w+jsj$",                "=KbvUQjsj",         9      ),
		(true,  ".?\\w+jsj$",                "^uDnoZjsj",         9      ),
		(true,  ".?\\w+jsj$",                "UzZbjsj",           7      ),
		(true,  ".?\\w+jsj$",                "\"wjsj",            5      ),
		(true,  ".?\\w+jsj$",                "zLa_FTEjsj",        10     ),
		(true,  ".?\\w+jsj$",                "\"mw3p8_Ojsj",      11     ),
		(true,  "^[\\+-]*[\\d]+$",           "+27",               3      ),
		(true,  "[abc]",                     "1c2",               1      ),
		(false, "[abc]",                     "1C2",               0      ),
		(true,  "[1-5]+",                    "0123456789",        5      ),
		(true,  "[.2]",                      "1C2",               1      ),
		(true,  "a*$",                       "Xaa",               2      ),
		(true,  "a*$",                       "Xaa",               2      ),
		(true,  "[a-h]+",                    "abcdefghxxx",       8      ),
		(false, "[a-h]+",                    "ABCDEFGH",          0      ),
		(true,  "[A-H]+",                    "ABCDEFGH",          8      ),
		(false, "[A-H]+",                    "abcdefgh",          0      ),
		(true,  "[^\\s]+",                   "abc def",           3      ),
		(true,  "[^fc]+",                    "abc def",           2      ),
		(true,  "[^d\\sf]+",                 "abc def",           3      ),
		(true,  "\n",                        "abc\ndef",          1      ),
		(true,  "b.\\s*\n",                  "aa\r\nbb\r\ncc\r\n\r\n", 4      ),
		(true,  ".*c",                       "abcabc",            6      ),
		(true,  ".+c",                       "abcabc",            6      ),
		(true,  "[b-z].*",                   "ab",                1      ),
		(true,  "b[k-z]*",                   "ab",                1      ),
		(false, "[0-9]",                     "  - ",              0      ),
		(true,  "[^0-9]",                    "  - ",              1      ),
		(true,  "0|",                        "0|",                2      ),
		(false, "\\d\\d:\\d\\d:\\d\\d",      "0s:00:00",          0      ),
		(false, "\\d\\d:\\d\\d:\\d\\d",      "000:00",            0      ),
		(false, "\\d\\d:\\d\\d:\\d\\d",      "00:0000",           0      ),
		(false, "\\d\\d:\\d\\d:\\d\\d",      "100:0:00",          0      ),
		(false, "\\d\\d:\\d\\d:\\d\\d",      "00:100:00",         0      ),
		(false, "\\d\\d:\\d\\d:\\d\\d",      "0:00:100",          0      ),
		(true,  "\\d\\d?:\\d\\d?:\\d\\d?",   "0:0:0",             5      ),
		(true,  "\\d\\d?:\\d\\d?:\\d\\d?",   "0:00:0",            6      ),
		(true,  "\\d\\d?:\\d\\d?:\\d\\d?",   "0:0:00",            5      ),
		(true,  "\\d\\d?:\\d\\d?:\\d\\d?",   "00:0:0",            6      ),
		(true,  "\\d\\d?:\\d\\d?:\\d\\d?",   "00:00:0",           7      ),
		(true,  "\\d\\d?:\\d\\d?:\\d\\d?",   "00:0:00",           6      ),
		(true,  "\\d\\d?:\\d\\d?:\\d\\d?",   "0:00:00",           6      ),
		(true,  "\\d\\d?:\\d\\d?:\\d\\d?",   "00:00:00",          7      ),
		(true,  "[Hh]ello [Ww]orld\\s*[!]?", "Hello world !",     12     ),
		(true,  "[Hh]ello [Ww]orld\\s*[!]?", "hello world !",     12     ),
		(true,  "[Hh]ello [Ww]orld\\s*[!]?", "Hello World !",     12     ),
		(true,  "[Hh]ello [Ww]orld\\s*[!]?", "Hello world!   ",   11     ),
		(true,  "[Hh]ello [Ww]orld\\s*[!]?", "Hello world  !",    13     ),
		(true,  "[Hh]ello [Ww]orld\\s*[!]?", "hello World    !",  15     ),
		(false, "\\d\\d?:\\d\\d?:\\d\\d?",   "a:0",               0      ), /* Failing test case reported in https://github.com/kokke/tiny-regex-c/issues/12 ) */ /*
		( true,  "[^\\w][^-1-4]",     ")T",           2      ),
		( true,  "[^\\w][^-1-4]",     ")^",           2      ),
		( true,  "[^\\w][^-1-4]",     "*)",           2      ),
		( true,  "[^\\w][^-1-4]",     "!.",           2      ),
		( true,  "[^\\w][^-1-4]",     " x",           2      ),
		( true,  "[^\\w][^-1-4]",     "$b",           2      ),
		*/
		(true,  ".?bar",                      "real_bar",         4      ),
		(false, ".?bar",                      "real_foo",         0      ),
		(false, "X?Y",                        "Z",                0      ),
		(true, "[a-z]+\nbreak",              "blahblah\nbreak",   14     ),
		(true, "[a-z\\s]+\nbreak",           "bla bla \nbreak",   14     )
		);

	public static void test()
	{
		for (let t in tests)
		{
			let (succeed, pattern, text, correctlen) = t;
			int32 length = 0;
			int m = re_match(pattern, text, &length);

			if (succeed)
			{
				Debug.Assert(length == correctlen);
			}
		}
	}
}