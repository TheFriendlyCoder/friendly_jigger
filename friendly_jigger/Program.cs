using System;
using System.Collections.Generic;
using CommandLine;

/*
 * In order to make this work with .NET 5.0 I had to enable 
 * inclusion of native binaries which prevents certain 
 * optimizations like the ready to run flag. This necessitates 
 * having to extract the binary to a temp folder every time you 
 * run it which slows startup times. The only solution is to use 
 * .NET 3.1 instead. Bug is reported here: 
 * https://github.com/dotnet/runtime/issues/36590
 * 
 * We could work around the problem by packaging the several files that
 * are normally generated in .NET 5 into an installation package but we'd
 * need to find a way to create platform specific packages and cross-compile
 * those as well which may be hard.
 * 
 * Also, we can not do platform optimizations while running builds on the
 * Travis CI docker environment for some reason. May need further investigation
 * to see if there is a fix.
 */
namespace friendly_jigger
{
    class Program
    {
        static void Main(string[] args)
        {
            Parser.Default.ParseArguments<Options>(args)
                .WithParsed(Run)
                .WithNotParsed(HandleParseError);
        }

        private static void HandleParseError(IEnumerable<Error> errs)
        {
            if (errs.IsVersion())
            {
                Console.WriteLine("Version Request");
                return;
            }

            if (errs.IsHelp())
            {
                Console.WriteLine("Help Request");
                return;
            }
            Console.WriteLine("Parser Fail");
        }

        private static void Run(Options opts)
        {
            Console.WriteLine("Parser success");
        }
    }
}
