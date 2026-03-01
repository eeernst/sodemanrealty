module.exports = function (eleventyConfig) {
  eleventyConfig.addPassthroughCopy({ "src/assets": "assets" });

  eleventyConfig.addCollection("posts", function (collectionApi) {
    return collectionApi.getFilteredByGlob("src/blog/*.md").sort((a,b) => b.date - a.date);
  });

  return {
    dir: { input: "src", includes: "_includes", data: "_data", output: "dist" },
    markdownTemplateEngine: "njk",
    htmlTemplateEngine: "njk"
  };
};
