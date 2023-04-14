using Architecture.Foundation.AuditTrail;

namespace AF.AuditTrail.Sample
{
    /// <summary>
    /// Implement interface 'IAFAuditable'
    /// Return Name of Primary key in property 'GetAuditParentKey'
    /// In case there are composite primary key, return all keys part of primary key
    /// add attribute 'AFAuditExclude' to exclude the property value being audited.
    /// </summary>
    public sealed class AuditTrailEntity : IAFAuditable
    {
        public Guid EmpID { get; set; }

        public string Name { get; set; }

        public string Address { get; set; }

        public string EMail { get; set; }

        [AFAuditExclude]
        public string Phone { get; set; }

        public IList<string> GetAuditParentKey()
        {
            return new List<string>();
        }

        public IList<string> GetAuditPrimaryKey()
        {
            return new List<string> { "EmpID" };
        }
    }
}
