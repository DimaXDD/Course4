using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.DynamicData;
using System.Web.Http;
using System.Web.Mvc;
using System.Web.SessionState;
using Lab8.Models;

namespace Lab8.Controllers
{
    [SessionState(SessionStateBehavior.Required)]
    public class JRServiceController : ApiController
    {
        private static bool ignoreMethods = false;

        [System.Web.Http.HttpPut]

        public object[] Multi([FromBody] ReqJsonRPC[] body)
        {
            int length = body.Length;
            object[] result = new object[length];

            for (int i = 0; i < length; i++)
                result[i] = Single(body[i]);

            //result.JsonRequestBehavior = JsonRequestBehavior.AllowGet;
            return result;
        }


        [System.Web.Http.HttpPost]
        public object Single(ReqJsonRPC body)
        {
            if (ignoreMethods)
                return GetError(body.Id, body.JsonRPC, new ErrorJsonRPC { Message = "Methods are not available", Code = -32601 });

            //int length = body.Length;


            string method = body.Method;
            DataModel param = body.Params;
            string key = param.Key;
            int value = int.Parse(param.Value == null || param.Value == "" ? "0" : param.Value); // default value = 0
            int? result = null;
            //var ret = new JsonResult();

            switch (method)
            {
                case "SetM":
                    {
                        result = SetM(key, value);
                        break;
                    }
                case "GetM":
                    {
                        result = GetM(key);
                        break;
                    }
                case "AddM":
                    {
                        result = AddM(key, value);
                        break;
                    }
                case "SubM":
                    {
                        result = SubM(key, value);
                        break;
                    }
                case "MulM":
                    {
                        result = MulM(key, value);
                        break;
                    }
                case "DivM":
                    {
                        if (value == 0)
                            return GetError(body.Id, body.JsonRPC, new ErrorJsonRPC { Message = string.Format("Attempt to divide by zero", body.Method), Code = -32602 });
                        result = DivM(key, value);
                        break;
                    }
                case "ErrorExit":
                    {
                        ErrorExit();
                        break;
                    }
                default:
                    {
                        return GetError(body.Id, body.JsonRPC, new ErrorJsonRPC { Message = string.Format("Function {0} is not found", body.Method), Code = -32601 });
                    }
            }
            return
             new ResJsonRPC()
             {
                 Id = body.Id,
                 JsonRPC = body.JsonRPC,
                 Method = body.Method,
                 Result = result
             };


        }


        ////////////////////////////////////
        private object GetError(string id, string jsonRPC, ErrorJsonRPC error)
        {

            return new ResJsonRPCError()
            {
                Id = id,
                JsonRPC = jsonRPC,
                Error = error
            };

        }
        ////////////////////////////////////
        private int? SetM(string k, int x)
        {
            HttpContext.Current.Session[k] = x;
            return GetM(k);
        }

        private int? GetM(string k)
        {
            object result = HttpContext.Current.Session[k];
            if (result == null)
                return null;
            else
                return int.Parse(result.ToString());
        }

        private int? AddM(string k, int x)
        {
            int? value = GetM(k);
            HttpContext.Current.Session[k] = value == null ? x : value + x;
            return GetM(k);
        }

        private int? SubM(string k, int x)
        {
            int? value = GetM(k);
            HttpContext.Current.Session[k] = value == null ? x : value - x;
            return GetM(k);
        }

        private int? MulM(string k, int x)
        {
            int? value = GetM(k);
            HttpContext.Current.Session[k] = value == null ? x : value * x;
            return GetM(k);
        }

        private int? DivM(string k, int x)
        {
            int? value = GetM(k);

            HttpContext.Current.Session[k] = value == null ? x : value / x;
            return GetM(k);
        }

        private void ErrorExit()
        {
            HttpContext.Current.Session.Clear();
            //HttpContext.Session["MethodsIgnore"] = true;
            ignoreMethods = true;
        }
    }
}