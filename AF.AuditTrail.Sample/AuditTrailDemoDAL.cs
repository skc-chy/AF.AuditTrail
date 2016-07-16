using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using Architecture.Foundation.DataAccessor;
using Architecture.Foundation.DataAccessor.SqlClient;
using Architecture.Foundation.AuditTrail;

namespace AF.AuditTrail.Sample
{
    /// <summary>
    /// Audit trail implemented
    /// Check 'AddEmployee', 'UpdateEmployee' and 'DeleteEmployee' method
    /// </summary>
    [AFDataStore("AF")]
    public class AuditTrailDemoDAL : AFDataStoreAccessor, IAuditTrailDemoDAL
    {
        public Result AddEmployee(AuditTrailEntity employeeData)
        {
            var result = new Result() { IsValid = false };

            StoreProcedureCommand procedure = CreateProcedureCommand("dbo.InsertEmployee");
            procedure.AppendGuid("EmpID", employeeData.EmpID);
            procedure.AppendNVarChar("Name", employeeData.Name);
            procedure.AppendNVarChar("Address", employeeData.Address);
            procedure.AppendNVarChar("EMail", employeeData.EMail);
            procedure.AppendNVarChar("Phone", employeeData.Phone);

            int resultValue = ExecuteCommand(procedure);

            if (resultValue == 0)
            {
                //Implement Audit trail
                //if Audittype is XMLFormat, then the whole entity would be saved in database and 'AuditableExclude' would be override.
                AFAudit.AuditTrail<AuditTrailEntity>(employeeData, new Guid("B40BCBDC-2B75-4E52-824B-093C5F1CD172"), AuditType.StringFormat, ActivityType.Insert, new Guid("702D796B-6C52-40F1-93EE-8BB004E32B2F"));

                result.IsValid = true;
                result.Message = new List<string> { "Employee added successfully" };
            }

            return result;
        }

        public Result UpdateEmployee(AuditTrailEntity employeeData)
        {
            var result = new Result() { IsValid = false };

            StoreProcedureCommand procedure = CreateProcedureCommand("dbo.UpdateEmployee");
            procedure.AppendGuid("EmpID", employeeData.EmpID);
            procedure.AppendNVarChar("Address", employeeData.Address);
            procedure.AppendNVarChar("EMail", employeeData.EMail);
            procedure.AppendNVarChar("Phone", employeeData.Phone);

            int resultValue = ExecuteCommand(procedure);

            if (resultValue == 0)
            {
                //Implement Audit trail
                //if Audittype is XMLFormat, then the whole entity would be saved in database and 'AuditableExclude' would be override.
                AFAudit.AuditTrail<AuditTrailEntity>(employeeData, new Guid("B40BCBDC-2B75-4E52-824B-093C5F1CD172"), AuditType.StringFormat, ActivityType.Update, new Guid("702D796B-6C52-40F1-93EE-8BB004E32B2F"));

                result.IsValid = true;
                result.Message = new List<string> { "Employee updated successfully" };
            }

            return result;
        }

        public Result DeleteEmployee(Guid empID)
        {
            var result = new Result() { IsValid = false };

            StoreProcedureCommand procedure = CreateProcedureCommand("dbo.DeleteEmployee");
            procedure.AppendGuid("EmpID", empID);

            int resultValue = ExecuteCommand(procedure);

            if (resultValue == 0)
            {
                //Implement Audit trail
                //if there is no entity for operations, then implement as per below steps
                //in case there is no entity, audit type would be always 'StringFormat'

                var dataCollection = new Dictionary<String, String>();
                dataCollection.Add("EmpID", empID.ToString());

                var primaryKey = new List<String>();
                primaryKey.Add("EmpID");

                var parentKey = new List<String>();
                AFAudit.AuditTrail(dataCollection, primaryKey, parentKey, new Guid("B40BCBDC-2B75-4E52-824B-093C5F1CD172"), ActivityType.Delete, new Guid("702D796B-6C52-40F1-93EE-8BB004E32B2F"));

                result.IsValid = true;
                result.Message = new List<string> { "Employee deleted successfully" };
            }

            return result;
        }

        public List<AuditTrailEntity> GetEmployeeList()
        {
            var empList = new List<AuditTrailEntity>();

            SqlDataReader reader = null;

            try
            {
                StoreProcedureCommand procedure = CreateProcedureCommand("dbo.GetEmployee");
                reader = ExecuteCommandAndReturnDataReader(procedure);

                while (reader.Read())
                    empList.Add(new AuditTrailEntity { EmpID = new Guid(reader["EmpID"].ToString()), Name = reader["Name"].ToString(), Address = reader["Address"].ToString(), EMail = reader["EMail"].ToString(), Phone = reader["Phone"].ToString() });

                reader.Close();
            }
            catch (Exception ex)
            {
                reader.Close();
                throw ex;
            }

            return empList;
        }
    }
}
