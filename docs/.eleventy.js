const { DateTime } = require("luxon");

module.exports = function (eleventyConfig) {
  eleventyConfig.addPassthroughCopy({ "src/assets": "assets" });
  eleventyConfig.ignores.add("src/assets/img/CREDITS.md");

  eleventyConfig.addFilter("date", function(dateObj, format) {
    return DateTime.fromJSDate(dateObj).toFormat(format);
  });
  eleventyConfig.addFilter("upper", function(str) {
    return String(str || "").toUpperCase();
  });

  eleventyConfig.addCollection("posts", function (collectionApi) {
    return collectionApi.getFilteredByGlob("src/blog/*.md").sort((a,b) => b.date - a.date);
  });

  return {
    dir: { input: "src", includes: "_includes", data: "_data", output: "dist" },
    markdownTemplateEngine: "njk",
    htmlTemplateEngine: "njk"
  };
};
