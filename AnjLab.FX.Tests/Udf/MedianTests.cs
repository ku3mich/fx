using AnjLab.FX.SQLServer.Udf;
using NUnit.Framework;

namespace AnjLab.FX.Tests.Udf
{
    [TestFixture]
    public class MedianTests
    {
        [Test]
        public void TestMedianEvenCount()
        {
            var m = new Median();
            m.Init();
            m.Accumulate(new Pair { Value = 1, Name = "1" });
            m.Accumulate(new Pair { Value = 1, Name = "1" });
            m.Accumulate(new Pair { Value = 5, Name = "5" });
            m.Accumulate(new Pair { Value = 7, Name = "7" });
            m.Accumulate(new Pair { Value = 8, Name = "8" });
            m.Accumulate(new Pair { Value = 1000, Name = "1000" });
            m.Accumulate(new Pair { Value = 10000, Name = "10000" });
            Assert.AreEqual("7", m.Terminate().Value);
        }

        [Test]
        public void TestMedianOddCount()
        {
            var m = new Median();
            m.Init();
            m.Accumulate(new Pair { Value = 1, Name = "1" });
            m.Accumulate(new Pair { Value = 1, Name = "1" });
            m.Accumulate(new Pair { Value = 5, Name = "5" });
            m.Accumulate(new Pair { Value = 6, Name = "6" });
            m.Accumulate(new Pair { Value = 1000, Name = "1000" });
            m.Accumulate(new Pair { Value = 10000, Name = "10000" });
            Assert.AreEqual("5 - 6", m.Terminate().Value); // Excel gives 5.5 here
        }
    }
}