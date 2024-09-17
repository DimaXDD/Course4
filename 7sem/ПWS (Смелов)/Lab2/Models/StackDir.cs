using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Services_Lab2.Models
{
    public class StackDir
    {
        public static Stack<int> _stackdata = new Stack<int>();
        public static int _result = 0;

        public static object OutPut(int result, Stack<int> stack)
        {
            if (stack != null && stack.Count() != 0)
            {
                return new { final_result = result + stack.Peek(), result = result, stackdata = stack };
            }
            return new { final_result = result, result = result, stackdata = "Stack is empty" };
        }
    }
}