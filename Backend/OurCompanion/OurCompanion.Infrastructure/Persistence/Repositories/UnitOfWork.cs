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
        public IGenericRepository<UserSession> UserSessions { get; private set; }
        public IGenericRepository<UserProfiles> UserProfiles { get; }
        public IGenericRepository<CompanionCategories> CompanionCategories { get; }
        public IGenericRepository<UserFiles> UserFiles { get; }
        public IGenericRepository<Categories> Categories { get; }

        public UnitOfWork(ApplicationDbContext context)
        {
            _context = context;

            // initialize the generic repositories for our tables
            Accounts = new GenericRepository<Account>(_context);
            UserSessions = new GenericRepository<UserSession>(_context);
            UserProfiles = new GenericRepository<UserProfiles>(_context);
            CompanionCategories = new GenericRepository<CompanionCategories>(_context);
            UserFiles = new GenericRepository<UserFiles>(_context);
            Categories = new GenericRepository<Categories>(_context);
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
