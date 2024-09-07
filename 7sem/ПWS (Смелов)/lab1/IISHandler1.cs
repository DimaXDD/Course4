using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.SessionState;

namespace lab1
{
    public class IISHandler1 : IHttpHandler, IRequiresSessionState
    {
        private static int result = 0;

        #region Члены IHttpHandler

        public bool IsReusable => false;

        public void ProcessRequest(HttpContext context)
        {
            if (context.Session["stackSession"] == null)
                context.Session["stackSession"] = new Stack<int>();

            Stack<int> stack = context.Session["stackSession"] as Stack<int>;

            string requestType = context.Request.HttpMethod;
            switch (requestType)
            {
                case "GET":
                    context.Response.ContentType = "application/json";
                    if (stack.Count == 0)
                        context.Response.Write("{\"result\": " + result + "}");
                    else
                        context.Response.Write("{\"result\": " + (result + stack.Peek()) + "}");
                    break;
                case "POST":
                    result = Convert.ToInt32(context.Request.QueryString["result"]);
                    break;
                case "PUT":
                    int add = Convert.ToInt32(context.Request.QueryString["add"]);
                    stack.Push(add);
                    break;
                case "DELETE":
                    if (stack.Count != 0)
                        stack.Pop();
                    break;
                default:
                    context.Response.StatusCode = 405;
                    context.Response.End();
                    break;
            }

        }
        #endregion
    }
}
