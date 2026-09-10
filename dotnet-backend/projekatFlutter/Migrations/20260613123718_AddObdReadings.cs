using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace projekatFlutter.Migrations
{
    /// <inheritdoc />
    public partial class AddObdReadings : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "ObdReadings",
                columns: table => new
                {
                    Id = table.Column<long>(type: "bigint", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    VehicleId = table.Column<int>(type: "int", nullable: false),
                    DeviceId = table.Column<int>(type: "int", nullable: true),
                    RPM = table.Column<int>(type: "int", nullable: true),
                    Speed = table.Column<decimal>(type: "decimal(6,2)", nullable: true),
                    EngineTemp = table.Column<decimal>(type: "decimal(5,2)", nullable: true),
                    EngineLoad = table.Column<decimal>(type: "decimal(5,2)", nullable: true),
                    FuelLevel = table.Column<decimal>(type: "decimal(5,2)", nullable: true),
                    AnomalyScore = table.Column<double>(type: "float", nullable: true),
                    IsAnomaly = table.Column<bool>(type: "bit", nullable: true),
                    RecordedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    ReceivedAt = table.Column<DateTime>(type: "datetime2", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ObdReadings", x => x.Id);
                    table.ForeignKey(
                        name: "FK_ObdReadings_DeviceTrackers_DeviceId",
                        column: x => x.DeviceId,
                        principalTable: "DeviceTrackers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_ObdReadings_Vehicles_VehicleId",
                        column: x => x.VehicleId,
                        principalTable: "Vehicles",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_ObdReadings_DeviceId",
                table: "ObdReadings",
                column: "DeviceId");

            migrationBuilder.CreateIndex(
                name: "IX_ObdReadings_VehicleId",
                table: "ObdReadings",
                column: "VehicleId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "ObdReadings");
        }
    }
}
