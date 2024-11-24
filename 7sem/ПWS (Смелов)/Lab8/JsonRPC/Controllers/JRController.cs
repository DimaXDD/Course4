using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.Http;
using Newtonsoft.Json;
using System.Web.Services.Description;
using JsonRPC.Service;
using JsonRPC.Models;

namespace JsonRPC.Controllers
{
    [RoutePrefix("jr")]
    public class JRController : ApiController
    {
        private readonly JRService _jrService;

        public JRController()
        {
            _jrService = new JRService();
        }

        [HttpPost]
        public async Task<IHttpActionResult> Process(object reqData)
        {
            try
            {
                Type valueType = reqData.GetType();
                if (valueType.Name == "JArray")
                {
                    var rpcs = JsonConvert.DeserializeObject<JsonRPCReq[]>(reqData.ToString());
                    var res = new List<JsonRPCRes>();
                    for (var i = 0; i < rpcs.Length; i++)
                    {
                        var rpcRes1 = _jrService.ProcessMethod(rpcs[i]);
                        if (rpcRes1 != null && rpcRes1.Id != null)
                            res.Add(rpcRes1);
                    }
                    return Ok(res);
                }

                var rpc = JsonConvert.DeserializeObject<JsonRPCReq>(reqData.ToString());
                var rpcRes = _jrService.ProcessMethod(rpc);
                if (rpcRes == null || rpcRes != null && rpcRes.Id == null)
                {
                    return Ok();
                }

                return Ok(rpcRes);
            }
            catch (Exception ex)
            {
                int? id = null;
                if (reqData != null)
                {
                    var property = reqData.GetType().GetProperty("id");

                    if (property != null)
                    {
                        var value = property.GetValue(reqData);
                        if (value != null)
                        {
                            if (int.TryParse(value.ToString(), out var idVal))
                            {
                                id = idVal;
                            }
                        }
                    }
                }

                return Ok(new JsonRPCRes
                {
                    Id = id,
                    Error = new RpcError
                    {
                        Code = -32700,
                        Message = "Parse error"
                    },
                    Jsonrpc = "2.0"
                });
            }
        }
    }
}