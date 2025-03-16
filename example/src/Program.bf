using System;
using System.Collections;
using System.Diagnostics;
using System.IO;
using System.Interop;
using System.Text;

using static tinyregexc.tinyregexc;

namespace example;

static class Program
{
	static int Main(params String[] args)
	{
		/* Test 1: inverted set without a closing ']' */
		Debug.Assert(re_compile("\\\x01[^\\\xff][^") == null);

		/* Test 2: set with an incomplete escape sequence and without a closing ']' */
		Debug.Assert(re_compile("\\\x01[^\\\xff][\\") == null);

		Test1.test();

		return 0;
	}
}