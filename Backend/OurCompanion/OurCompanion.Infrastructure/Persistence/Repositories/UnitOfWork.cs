using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using OurCompanion.Application.Interfaces.Repositories;
using OurCompanion.Domain.Entities;
using OurCompanion.Infrastructure.Persistence;

namespace OurCompanion.Infrastructure.Persistence.Repositories
{
    public class UnitOfWork : IUnitOfWork
    {
        private readonly ApplicationDbContext _context;

        //store our repositories here
        public IGenericRepository<Account> Accounts { get; private set; }
        public IGenericRepository<OtpVerification> OtpVerifications { get; private set; }
        public IGenericRepository<UserSession> UserSessions { get; private set; }

        public UnitOfWork(ApplicationDbContext context)
        {
            _context = context;

            // initialize the generic repositories for our tables
            Accounts = new GenericRepository<Account>(_context);
            OtpVerifications = new GenericRepository<OtpVerification>(_context);
            UserSessions = new GenericRepository<UserSession>(_context);
        }


        public async Task<int> SaveAsync(CancellationToken cancellationToken = default)
        {
            //this executes the SQL transaction
            return await _context.SaveChangesAsync(cancellationToken);
        }
        public void Dispose()
        {
            _context.Dispose();
        }

    }
}
