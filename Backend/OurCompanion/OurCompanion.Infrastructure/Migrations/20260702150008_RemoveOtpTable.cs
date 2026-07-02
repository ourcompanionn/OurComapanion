using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace OurCompanion.Infrastructure.Migrations
{
    /// <inheritdoc />
    public partial class RemoveOtpTable : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "OtpVerifications");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
        }
    }
}
