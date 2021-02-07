using System;
using Xunit;
using friendly_jigger;

namespace tests
{
    public class InitTests
    {
        [Fact]
        public void TestNoOp()
        {
            string[] args = new string[] {"Hello"};
            //string[] args = new string[0];

            int exitCode = Program.Main(args);
            Assert.Equal(0, exitCode);
        }
    }
}
