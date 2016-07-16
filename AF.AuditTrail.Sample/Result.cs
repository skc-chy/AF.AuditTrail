using System.Collections.Generic;

namespace AF.AuditTrail.Sample
{
    public class Result
    {
        public bool IsValid { get; set; }
        public IList<string> Message { get; set; }
    }
}