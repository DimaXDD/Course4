namespace lab5
{
    public class WCFSiplex : IWCFSiplex
    {
        public int Add(int x, int y) => x + y;
        public string Concat(string s, double d) => s + d;
        public A Sum(A a1, A a2) => new A(a1.s + a2.s, a1.k + a2.k, a1.f + a2.f);
    }
}
