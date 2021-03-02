using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ExamenUWPBL.Excepciones
{
    public class DepartmentContainsPeopleException : Exception
    {
        public DepartmentContainsPeopleException() : base() { }
        public DepartmentContainsPeopleException(string message) : base(message) { }
        public DepartmentContainsPeopleException(string message, Exception inner) : base(message, inner) { }
    }
}
