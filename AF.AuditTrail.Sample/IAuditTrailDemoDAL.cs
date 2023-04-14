namespace AF.AuditTrail.Sample
{

    public interface IAuditTrailDemoDAL
    {
        Result AddEmployee(AuditTrailEntity employeeData);

        Result UpdateEmployee(AuditTrailEntity employeeData);

        Result DeleteEmployee(Guid empID);

        List<AuditTrailEntity> GetEmployeeList();
    }
}
