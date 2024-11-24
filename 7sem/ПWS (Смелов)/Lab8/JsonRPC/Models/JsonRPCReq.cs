using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace JsonRPC.Models
{
    public class JsonRPCReq
    {
        public int? Id { get; set; }
        public string Method { get; set; }
        public JsonParams Params { get; set; } = new JsonParams();
        public string Jsonrpc { get; set; }
    }

    public class JsonParams
    {
        public string K { get; set; } = null;
        public int? X { get; set; } = null;
    }
}