using System;
using System.Web.Http;
using Services_Lab2.Models;

namespace Services_Lab2.Controllers
{
    public class StackDirController : ApiController 
    {
        [HttpGet]
        public object Get()
        {
            return StackDir.OutPut( StackDir._result, StackDir._stackdata);
        }

        [HttpPost]
        public object Post([FromUri] string result)
        {
            if (int.TryParse(result, out var number))
            {
                StackDir._result = number;              
                return StackDir.OutPut(StackDir._result, StackDir._stackdata);
            }
            else
                return new { error = new { message = "Type of Params is not Integer", _result = result } };
        }

        [HttpPut]
        public object Put([FromUri] string add)
        {
            if (Int32.TryParse(add, out var number))
            {
                StackDir._stackdata.Push(number);
                return StackDir.OutPut(StackDir._result, StackDir._stackdata);
            }
            else
                return new { error = new { message = "Type of Params is not Integer", _result = add } };
        }

        [HttpDelete]
        public object Delete()
        {
            var stack = StackDir._stackdata; 
            var result = StackDir._result;
            if (stack.Count == 0) 
                return new { final_result = result, result = result, stackdata = "Stack is empty" };
            stack.Pop();
            return StackDir.OutPut(result, stack);
        }
    }
}