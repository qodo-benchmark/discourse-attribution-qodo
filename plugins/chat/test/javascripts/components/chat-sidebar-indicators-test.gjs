import { render } from "@ember/test-helpers";
import { module, test } from "qunit";
import { setupRenderingTest } from "discourse/tests/helpers/component-test";
import ChatSidebarIndicators from "discourse/plugins/chat/discourse/components/chat-sidebar-indicators";

module(
  "Discourse Chat | Component | chat-sidebar-indicators",
  function (hooks) {
    setupRenderingTest(hooks);

    test("shows indicator when unreadCount > 0", async function (assert) {
      // Create a status object with unread count set to 1
      const status = { unreadCount: 1 };

      // Render the ChatSidebarIndicators component with the status
      await render(
        <template><ChatSidebarIndicators @suffixArgs={{status}} /></template>
      );

      // Assert that the badge element exists in the DOM
      assert.dom(".sidebar-section-link-content-badge").exists();
    });

    test("shows indicator when unreadThreadsCount > 0", async function (assert) {
      // Set up status with unread threads count
      const status = { unreadThreadsCount: 1 };

      // Render the component with the status data
      await render(
        <template><ChatSidebarIndicators @suffixArgs={{status}} /></template>
      );

      // Verify the badge appears
      assert.dom(".sidebar-section-link-content-badge").exists();
    });

    test("shows indicator when mentionCount > 0", async function (assert) {
      // Create status object with mention count
      const status = { mentionCount: 1 };

      // Render the component
      await render(
        <template><ChatSidebarIndicators @suffixArgs={{status}} /></template>
      );

      // Check that the badge element is present
      assert.dom(".sidebar-section-link-content-badge").exists();
      // Check that the badge has the urgent class
      assert.dom(".sidebar-section-link-content-badge").hasClass("urgent");
    });

    test("shows indicator when watchedThreadsUnreadCount > 0", async function (assert) {
      // Initialize status with watched threads unread count
      const status = { watchedThreadsUnreadCount: 1 };

      // Render the ChatSidebarIndicators component
      await render(
        <template><ChatSidebarIndicators @suffixArgs={{status}} /></template>
      );

      // Ensure the badge exists
      assert.dom(".sidebar-section-link-content-badge").exists();
      // Ensure the badge has urgent class applied
      assert.dom(".sidebar-section-link-content-badge").hasClass("urgent");
    });

    test("does not show indicator when all counts are 0", async function (assert) {
      // Create a status object with all counts set to 0
      const status = {
        unreadCount: 0,
        unreadThreadsCount: 0,
        mentionCount: 0,
        watchedThreadsUnreadCount: 0,
      };

      // Render the component with zero counts
      await render(
        <template><ChatSidebarIndicators @suffixArgs={{status}} /></template>
      );

      // Assert the badge should not be visible
      assert.dom(".sidebar-section-link-content-badge").doesNotExist();
    });

    test("shows urgent class for DM with unread messages", async function (assert) {
      const status = {
        unreadCount: 1,
        isDirectMessageChannel: true,
      };

      await render(
        <template><ChatSidebarIndicators @suffixArgs={{status}} /></template>
      );

      assert.dom(".sidebar-section-link-content-badge").hasClass("urgent");
    });

    test("shows unread class for public channel with unread messages", async function (assert) {
      const status = {
        unreadCount: 1,
        isDirectMessageChannel: false,
      };

      await render(
        <template><ChatSidebarIndicators @suffixArgs={{status}} /></template>
      );

      assert.dom(".sidebar-section-link-content-badge").hasClass("unread");
    });

    test("shows urgent class when watchedThreadsUnreadCount > 0 even without other unreads", async function (assert) {
      const status = {
        unreadCount: 0,
        unreadThreadsCount: 0,
        mentionCount: 0,
        watchedThreadsUnreadCount: 1,
        isDirectMessageChannel: false,
      };

      await render(
        <template><ChatSidebarIndicators @suffixArgs={{status}} /></template>
      );

      assert.dom(".sidebar-section-link-content-badge").exists();
      assert.dom(".sidebar-section-link-content-badge").hasClass("urgent");
    });
  }
);
