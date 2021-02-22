using System;
using Xunit;
using Xunit.Abstractions;
using friendly_jigger;

namespace tests
{
    public class InitTests
    {

        [Fact]
        public void TestInit()
        {
            string[] args = new string[0];

            int exitCode = Program.Main(args);
            Assert.Equal(0, exitCode);
        }

        [Fact]
        public void TestVersion()
        {
            string[] args = new string[] {"--version"};

            int exitCode = Program.Main(args);
            Assert.Equal(0, exitCode);
        }

        [Fact]
        public void TestHelp()
        {
            string[] args = new string[]{"--help"};

            int exitCode = Program.Main(args);
            Assert.Equal(0, exitCode);
        }

        [Fact]
        public void TestInvalid()
        {
            string[] args = new string[]{"--invalid"};

            int exitCode = Program.Main(args);
            Assert.Equal(0, exitCode);
        }
    }
}
