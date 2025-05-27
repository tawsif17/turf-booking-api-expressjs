import { PrismaClient } from '@prisma/client';
import fs from 'fs/promises';
import path from 'path';

const prisma = new PrismaClient();

async function loadJSON<T>(filename: string): Promise<T> {
  const filePath = path.join(process.cwd(), 'data', filename);
  const data = await fs.readFile(filePath, 'utf-8');
  return JSON.parse(data);
}

async function main() {
  const divisionsData = await loadJSON<{ divisions: any[] }>('divisions.json');
  const districtsData = await loadJSON<{ districts: any[] }>('districts.json');
  const dhakaData = await loadJSON<{ locations: any[] }>('dhaka.json');
  const otherData = await loadJSON<{ locations: any[] }>('locations.json');
  const rolesData = await loadJSON<{ roles: any[] }>('roles.json');
  console.log('🌍 Seeding Divisions...');
  for (const div of divisionsData.divisions) {
    await prisma.division.upsert({
      where: { id: parseInt(div.id) },
      update: {},
      create: {
        id: parseInt(div.id),
        name: div.name,
        bn_name: div.bn_name,
      },
    });
  }

  console.log('🏙️ Seeding Districts...');
  for (const dist of districtsData.districts) {
    await prisma.district.upsert({
      where: { id: parseInt(dist.id) },
      update: {},
      create: {
        id: parseInt(dist.id),
        division_id: parseInt(dist.division_id),
        name: dist.name,
        bn_name: dist.bn_name,
      },
    });
  }

  const allLocations = [...dhakaData.locations, ...otherData.locations];

  console.log('📍 Seeding Locations...');
  for (const loc of allLocations) {
    const baseData = {
      district_id: parseInt(loc.district_id),
      name: loc.name,
      bn_name: loc.bn_name,
    };

    if (loc.id) {
      await prisma.location.upsert({
        where: { id: parseInt(loc.id) },
        update: {},
        create: {
          id: parseInt(loc.id),
          ...baseData,
        },
      });
    } else {
      await prisma.location.create({ data: baseData });
    }
  }
  console.log('👥 Seeding Roles...');
  for (const role of rolesData.roles){
    await prisma.role.upsert({
        where: {role_id: role.id},
        update: {},
        create:{
            role_id:role.id,
            name:role.name
        }
    })
  }
  console.log('✅ Done seeding.');
}

main()
  .catch((e) => {
    console.error('❌ Seed failed:', e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
