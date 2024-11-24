using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using JsonRPC.Models;

namespace JsonRPC.Service
{
    public class JRService
    {
        private bool ignoreMethods = false;

        private void CheckRpcReq(JsonRPCReq rpc)
        {
            if (rpc == null)
                throw new RpcException("Parse error", -32700);

            if (rpc.Jsonrpc != "2.0")
                throw new RpcException("Invalid request", -32600);

            if (string.IsNullOrEmpty(rpc.Method))
                throw new RpcException("Method not found", -32601);
        }

        private void CheckOnKey(JsonRPCReq rpc)
        {
            if (rpc.Params == null || string.IsNullOrEmpty(rpc.Params.K))
                throw new RpcException("Invalid params", -32602);
        }

        private void CheckOnValue(JsonRPCReq rpc)
        {
            if (rpc.Params == null || rpc.Params.X == null)
                throw new RpcException("Invalid params", -32602);
        }

        private int GetValue(string key)
        {
            var data = HttpContext.Current.Session[key];
            if (data == null)
                return 0;

            if (int.TryParse(data.ToString(), out var value))
                return value;

            return 0;
        }

        private void SetValue(string key, int? value)
        {
            HttpContext.Current.Session[key] = value;
        }

        public JsonRPCRes ProcessMethod(JsonRPCReq rpc)
        {
            try
            {
                CheckRpcReq(rpc);
                if (ignoreMethods)
                    return null;

                var res = new JsonRPCRes
                {
                    Id = rpc.Id,
                    Jsonrpc = "2.0"
                };

                switch (rpc.Method)
                {
                    case "SetM":
                        CheckOnKey(rpc);
                        CheckOnValue(rpc);
                        SetValue(rpc.Params.K, rpc.Params.X);
                        res.Result = GetValue(rpc.Params.K);
                        break;
                    case "GetM":
                        CheckOnKey(rpc);
                        res.Result = GetValue(rpc.Params.K);
                        break;
                    case "AddM":
                        CheckOnKey(rpc);
                        CheckOnValue(rpc);
                        SetValue(rpc.Params.K, GetValue(rpc.Params.K) + rpc.Params.X);
                        res.Result = GetValue(rpc.Params.K);
                        break;
                    case "SubM":
                        CheckOnKey(rpc);
                        CheckOnValue(rpc);
                        SetValue(rpc.Params.K, GetValue(rpc.Params.K) - rpc.Params.X);
                        res.Result = GetValue(rpc.Params.K);
                        break;
                    case "MulM":
                        CheckOnKey(rpc);
                        CheckOnValue(rpc);
                        SetValue(rpc.Params.K, GetValue(rpc.Params.K) * rpc.Params.X);
                        res.Result = GetValue(rpc.Params.K);
                        break;
                    case "DivM":
                        CheckOnKey(rpc);
                        CheckOnValue(rpc);
                        SetValue(rpc.Params.K, GetValue(rpc.Params.K) / rpc.Params.X);
                        res.Result = GetValue(rpc.Params.K);
                        break;
                    case "ErrorExit":
                        ignoreMethods = true;
                        HttpContext.Current.Session.Clear();
                        break;
                    default:
                        throw new RpcException("Uknown method", -32601);
                }

                if (res.Result == null)
                    res.Result = "";

                return res;
            }
            catch (RpcException ex)
            {
                return new JsonRPCRes
                {
                    Id = rpc == null ? null : rpc.Id,
                    Error = new RpcError
                    {
                        Code = ex.Code,
                        Message = ex.Message
                    },
                    Jsonrpc = "2.0"
                };
            }
            catch (Exception ex)
            {
                return new JsonRPCRes
                {
                    Id = rpc == null ? null : rpc.Id,
                    Error = new RpcError
                    {
                        Code = -32603,
                        Message = "Internal error"
                    },
                    Jsonrpc = "2.0"
                };
            }
        }
    }
}