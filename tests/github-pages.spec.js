const { test, expect } = require('@playwright/test');

test.describe('GitHub Pages Deployment', () => {
  test('should load the main page', async ({ page }) => {
    await page.goto('');

    // Check that the page loads without errors
    await expect(page).toHaveTitle(/PVPWarn Voice Pack/);

    // Verify main heading exists
    const heading = page.locator('h1');
    await expect(heading).toBeVisible();
    await expect(heading).toContainText('PVPWarn Voice Pack');
  });

  test('should have functional class navigation buttons', async ({ page }) => {
    await page.goto('');

    // Check that class buttons exist
    const buttons = page.locator('.class-btn');
    await expect(buttons).toHaveCount(12); // 9 classes + 3 extras (items, racials, misc)

    // Test clicking on Warrior button
    await page.click('.class-btn[data-class="warrior"]');
    const warriorSection = page.locator('#warrior');
    await expect(warriorSection).toHaveClass(/active/);
  });

  test('should load audio players', async ({ page }) => {
    await page.goto('');

    // Navigate to warrior section
    await page.click('.class-btn[data-class="warrior"]');

    // Wait for section to be active
    await page.waitForSelector('#warrior.active');

    // Check that audio elements exist
    const audioElements = page.locator('#warrior audio');
    const count = await audioElements.count();
    expect(count).toBeGreaterThan(0);

    // Verify audio sources are set (using source element)
    const firstAudioSource = page.locator('#warrior audio source').first();
    const src = await firstAudioSource.getAttribute('src');
    expect(src).toBeTruthy();
    expect(src).toMatch(/\.mp3$/);
  });

  test('should have working audio file links', async ({ page, request }) => {
    await page.goto('');

    // Wait for page to load
    await page.waitForSelector('.class-btn');

    // Get all audio source elements
    const audioSources = await page.locator('audio source').evaluateAll(
      elements => elements.map(el => el.src)
    );

    // Test that at least some audio files exist
    expect(audioSources.length).toBeGreaterThan(0);

    // Skip HTTP checks in local environment to avoid IPv6 issues
    if (process.env.CI && process.env.GITHUB_PAGES_URL) {
      // Check that first few audio files are accessible
      for (let i = 0; i < Math.min(3, audioSources.length); i++) {
        const response = await request.head(audioSources[i]);
        expect(response.ok()).toBeTruthy();
      }
    } else {
      // For local testing, just verify the audio sources have the correct format
      audioSources.slice(0, 3).forEach(src => {
        expect(src).toMatch(/\.mp3$/);
        expect(src).toContain('/assets/sounds/');
      });
    }
  });

  test('should navigate between different class sections', async ({ page }) => {
    await page.goto('');

    // Start with Druid (default active)
    await expect(page.locator('#druid')).toHaveClass(/active/);

    // Navigate to Mage
    await page.click('.class-btn[data-class="mage"]');
    await expect(page.locator('#mage')).toHaveClass(/active/);
    await expect(page.locator('#druid')).not.toHaveClass(/active/);

    // Navigate to Warrior
    await page.click('.class-btn[data-class="warrior"]');
    await expect(page.locator('#warrior')).toHaveClass(/active/);
    await expect(page.locator('#mage')).not.toHaveClass(/active/);
  });
});
