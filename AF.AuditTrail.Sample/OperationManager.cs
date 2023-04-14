using AF.AuditTrail.Sample;

namespace AF.DataAccessor.Sample
{
    public sealed class OperationManager
    {
        public void AddEmployee()
        {
            Console.Clear();
            IAuditTrailDemoDAL auditTrailDemoDAL = new AuditTrailDemoDAL();
            AuditTrailEntity auditTrailEntity = new AuditTrailEntity();
            auditTrailEntity.EmpID = Guid.NewGuid();

            Console.WriteLine("Enter Name:");
            auditTrailEntity.Name = Console.ReadLine();

            Console.WriteLine("Enter Address:");
            auditTrailEntity.Address = Console.ReadLine();

            Console.WriteLine("Enter EMail:");
            auditTrailEntity.EMail = Console.ReadLine();

            Console.WriteLine("Enter Phone:");
            auditTrailEntity.Phone = Console.ReadLine();

            var result = auditTrailDemoDAL.AddEmployee(auditTrailEntity);

            if (result.IsValid)
            {
                Console.WriteLine(result.Message[0]);
                Console.WriteLine("Press any key to continue");
                Console.ReadKey();
            }
        }

        public void UpdateEmployee()
        {
            Console.Clear();
            IAuditTrailDemoDAL auditTrailDemoDAL = new AuditTrailDemoDAL();
            AuditTrailEntity auditTrailEntity = new AuditTrailEntity();

            Console.WriteLine("Enter employee ID:");
            var empID = Console.ReadLine();
            auditTrailEntity.EmpID = empID == null ? Guid.Empty : Guid.Parse(empID);

            Console.WriteLine("Enter Address:");
            auditTrailEntity.Address = Console.ReadLine();

            Console.WriteLine("Enter EMail:");
            auditTrailEntity.EMail = Console.ReadLine();

            Console.WriteLine("Enter Phone:");
            auditTrailEntity.Phone = Console.ReadLine();

            var result = auditTrailDemoDAL.UpdateEmployee(auditTrailEntity);

            if (result.IsValid)
            {
                Console.WriteLine(result.Message[0]);
                Console.WriteLine("Press any key to continue");
                Console.ReadKey();
            }
        }

        public void DeleteEmployee()
        {

            Console.Clear();
            IAuditTrailDemoDAL auditTrailDemoDAL = new AuditTrailDemoDAL();
            AuditTrailEntity auditTrailEntity = new AuditTrailEntity();

            Console.WriteLine("Enter employee ID:");
            var empID = Console.ReadLine();
            auditTrailEntity.EmpID = empID == null ? Guid.Empty : Guid.Parse(empID);

            var result = auditTrailDemoDAL.DeleteEmployee(auditTrailEntity.EmpID);

            if (result.IsValid)
            {
                Console.WriteLine(result.Message[0]);
                Console.WriteLine("Press any key to continue");
                Console.ReadKey();
            }
        }

        public void ListEmployee()
        {
            Console.Clear();
            IAuditTrailDemoDAL auditTrailDemoDAL = new AuditTrailDemoDAL();
            AuditTrailEntity auditTrailEntity = new AuditTrailEntity();

            var empList = auditTrailDemoDAL.GetEmployeeList();

            if (empList.Count == 0)
                Console.WriteLine("No records found");

            foreach (var emp in empList)
            {
                Console.WriteLine("Employee ID: " + emp.EmpID);
                Console.WriteLine("Employee Name: " + emp.Name);
                Console.WriteLine("Employee Address:" + emp.Address);
                Console.WriteLine("Employee Email: " + emp.EMail);
                Console.WriteLine("Employee Phone: " + emp.Phone);

                Console.WriteLine();
                Console.WriteLine();
            }

            Console.WriteLine("Press any key to continue");
            Console.ReadKey();
        }
    }
}
