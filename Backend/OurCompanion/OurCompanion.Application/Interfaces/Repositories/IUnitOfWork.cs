using OurCompanion.Domain.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OurCompanion.Application.Interfaces.Repositories
{
    public interface IUnitOfWork : IDisposable
    {
        IGenericRepository<Account> Accounts { get; }
        IGenericRepository<UserSession> UserSessions { get; }
        IGenericRepository<UserProfiles> UserProfiles { get; }
        IGenericRepository<CompanionCategories> CompanionCategories { get; }
        IGenericRepository<UserFiles> UserFiles { get; }
        IGenericRepository<Categories> Categories { get; }

        Task<int> SaveAsync(CancellationToken cancellationToken = default);

    }
}
