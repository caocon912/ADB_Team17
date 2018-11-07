using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Db4objects.Db4o;
using Db4objects.Db4o.Linq;

namespace ADBTeam17_DB4O
{
    public class Manage
    {
        public static IObjectContainer OpenDB(string MSSV_EmployeeManager)
        {
            IObjectContainer db = Db4oEmbedded.OpenFile(MSSV_EmployeeManager);
            return db;
        }
        public static void InputCompay(IObjectContainer db)
        {
            int n = 2;
            while (n >= 0) {
                Console.Write("Nhap vao companyID:");
                int companyid = int.Parse(Console.ReadLine());

                Console.Write("Nhap vao companyName:");
                string companyname = Console.ReadLine();

                Console.Write("Nhap vao houseNumber:");
                string housenumber = Console.ReadLine();

                Console.Write("Nhap vao street:");
                string street = Console.ReadLine();

                Console.Write("Nhap vao city:");
                string city = Console.ReadLine();

                Company cp = new Company(companyid, companyname, housenumber, street, city);
                db.Store(cp);
                n--;
            }
        }
        public static void RetrieveAllCompany(IObjectContainer db)
        {
            IObjectSet result = db.QueryByExample(typeof(Company));
            ListResult(result);
        }
        public static void InputEmployee(IObjectContainer db)
        {
            int n = 5;
            while (n >= 0)
            {
                Console.Write("Nhap vao ID:");
                int ma = int.Parse(Console.ReadLine());

                Console.Write("Nhap vao ho ten:");
                string ten = Console.ReadLine();

                Console.Write("Nhap vao skill:");
                string skill = Console.ReadLine();

                Console.Write("Nhap vao homeBase:");
                string homeBase = Console.ReadLine();
                

                Console.Write("Nhap vao manager:");
                string manager = Console.ReadLine();

                Console.Write("Nhap vao salary");
                double salary = double.Parse(Console.ReadLine());

                
                Company cp = new Company(0, null, homeBase, null, null);
                Employee emp = new Employee(0, null, null, null, null, 0);

                Employee employee = new Employee(ma, ten, skill, cp, emp, salary);
                db.Store(employee);
                n--;
            }
        }
        public static void ListResult(IObjectSet result)
        {
            foreach (object item in result)
            {
                Console.WriteLine(item);
            }
        }
        public static void RetrieveAllEmployee(IObjectContainer db)
        {            
            IObjectSet result = db.QueryByExample(typeof(Employee));
            ListResult(result);
        }
        public static void cau7(IObjectContainer db)
        {
            
            IEnumerable<Company> rsListQuery = from Employee emp in db
                                               where emp.Salary > 500
                                               group emp by emp.HomeBase into CG
                                               where CG.Count() >= 2
                                               select CG.Key;
            List<Company> rs = new List<Company>();
            foreach (Company obj in rsListQuery)
            {
                rs.Add(obj);
            }
            db.Close();
            
        }

    }
}
