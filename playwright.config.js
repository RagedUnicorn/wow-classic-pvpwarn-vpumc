const { defineConfig, devices } = require('@playwright/test');

// Debug output
if (process.env.CI) {
  console.log('Running in CI environment');
  console.log('GITHUB_PAGES_URL:', process.env.GITHUB_PAGES_URL);
}

module.exports = defineConfig({
  testDir: './tests',
  timeout: 30 * 1000,
  expect: {
    timeout: 5000
  },
  fullyParallel: true,
  forbidOnly: !!process.env.CI,
  retries: process.env.CI ? 2 : 0,
  workers: process.env.CI ? 1 : undefined,
  reporter: 'html',
  use: {
    baseURL: process.env.GITHUB_PAGES_URL || 'http://localhost:8080',
    trace: 'on-first-retry',
  },

  projects: [
    {
      name: 'chromium',
      use: { ...devices['Desktop Chrome'] },
    },
  ],

  webServer: process.env.CI ? undefined : {
    command: 'npx http-server github_page -p 8080',
    port: 8080,
    reuseExistingServer: !process.env.CI,
  },
});
